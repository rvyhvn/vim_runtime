" Utility Functions
function! s:NormalizePath(path)
  return fnamemodify(a:path, ':p')
endfunction

function! s:IsInsidePath(child, parent)
  let l:child = s:NormalizePath(a:child)
  let l:parent = s:NormalizePath(a:parent)
  return l:child =~# '^' . escape(l:parent, '\')
endfunction

function! s:CountFiles(dir)
  let l:files = glob(a:dir . '/**/*', 0, 1)
  return len(filter(l:files, 'filereadable(v:val)'))
endfunction

function! s:BuildArchivePath(input_path)
  let l:input = s:NormalizePath(a:input_path)
  let l:archive = s:NormalizePath(g:archive_dir)
  let l:home = s:NormalizePath($HOME)
  
  " Check if archive_dir is nested within the input's directory tree
  " Find the common ancestor
  let l:input_parts = split(l:input, '/')
  let l:archive_parts = split(l:archive, '/')
  
  " Find if archive is nested in a parent of input
  let l:common_depth = 0
  for i in range(min([len(l:input_parts), len(l:archive_parts)]))
    if l:input_parts[i] ==# l:archive_parts[i]
      let l:common_depth = i + 1
    else
      break
    endif
  endfor
  
  " If archive_dir shares a parent with input (e.g., both in ~/Documents/my-notes/)
  " and archive is NOT a parent of input
  if l:common_depth > 0 && !s:IsInsidePath(l:input, l:archive)
    " Find the parent of archive_dir to use as anchor
    let l:anchor_parts = l:archive_parts[0:len(l:archive_parts)-2]
    
    " Check if this parent is also a parent of input
    let l:is_shared_parent = 1
    if len(l:input_parts) < len(l:anchor_parts)
      let l:is_shared_parent = 0
    else
      for i in range(len(l:anchor_parts))
        if l:input_parts[i] !=# l:anchor_parts[i]
          let l:is_shared_parent = 0
          break
        endif
      endfor
    endif
    
    if l:is_shared_parent
      " Use the parent of archive_dir as anchor
      let l:anchor = '/' . join(l:anchor_parts, '/')
      let l:relative = substitute(l:input, '^' . escape(l:anchor, '\') . '/', '', '')
      return l:archive . '/' . l:relative
    endif
  endif
  
  " Default: use HOME as anchor
  if s:IsInsidePath(l:input, l:home)
    let l:relative = substitute(l:input, '^' . escape(l:home, '\') . '/', '', '')
    return l:archive . '/' . l:relative
  else
    " If not in HOME, preserve full path structure
    return l:archive . l:input
  endif
endfunction

function! s:FindLocalArchiveDir(path)
  let l:current = s:NormalizePath(a:path)
  let l:parent = fnamemodify(l:current, ':h')
  return l:parent . '/archive'
endfunction

function! s:IsInLocalArchive(path)
  let l:path = s:NormalizePath(a:path)
  return l:path =~# '/archive/'
endfunction

function! s:ReverseArchivePath(archived_path, archive_root)
  let l:archived = s:NormalizePath(a:archived_path)
  let l:archive = s:NormalizePath(a:archive_root)
  
  if !s:IsInsidePath(l:archived, l:archive)
    return ''
  endif
  
  let l:relative = substitute(l:archived, '^' . escape(l:archive, '\') . '/', '', '')
  let l:home = s:NormalizePath($HOME)
  
  " Try to reconstruct original path
  " Check if the relative path looks like it was anchored to HOME
  return l:home . '/' . l:relative
endfunction

" Main Commands Implementation
function! archiver#ArchiveNote()
  let l:current_file = expand('%:p')
  
  if empty(l:current_file)
    echohl ErrorMsg
    echo "No file in current buffer"
    echohl None
    return
  endif
  
  if !filereadable(l:current_file)
    echohl ErrorMsg
    echo "Current buffer is not a readable file"
    echohl None
    return
  endif
  
  " Check if already archived
  if s:IsInsidePath(l:current_file, g:archive_dir)
    echohl WarningMsg
    echo "File is already in archive directory"
    echohl None
    return
  endif
  
  " Build archive path
  let l:archive_path = s:BuildArchivePath(l:current_file)
  
  " Create parent directories
  let l:archive_dir = fnamemodify(l:archive_path, ':h')
  if !isdirectory(l:archive_dir)
    call mkdir(l:archive_dir, 'p')
  endif
  
  " Move file
  if rename(l:current_file, l:archive_path) != 0
    echohl ErrorMsg
    echo "Failed to move file to archive"
    echohl None
    return
  endif
  
  " Reopen buffer at new location
  execute 'edit ' . fnameescape(l:archive_path)
  
  " Mark as readonly if configured
  if g:archiver_readonly_archived
    setlocal readonly
  endif
  
  echohl MoreMsg
  echo "Archived: " . fnamemodify(l:archive_path, ':~')
  echohl None
endfunction

function! archiver#ArchiveDir()
  let l:current_file = expand('%:p')
  let l:current_dir = empty(l:current_file) ? getcwd() : fnamemodify(l:current_file, ':h')
  let l:current_dir = s:NormalizePath(l:current_dir)
  
  " Check if already archived
  if s:IsInsidePath(l:current_dir, g:archive_dir)
    echohl WarningMsg
    echo "Directory is already in archive"
    echohl None
    return
  endif
  
  " Count files and confirm if too many
  let l:file_count = s:CountFiles(l:current_dir)
  if l:file_count > g:archiver_file_limit
    let l:response = input(printf("Archive %d files? (y/N): ", l:file_count))
    if l:response !~? '^y'
      echo "\nArchive cancelled"
      return
    endif
  endif
  
  " Build archive path
  let l:archive_path = s:BuildArchivePath(l:current_dir)
  
  " Create parent directory
  let l:archive_parent = fnamemodify(l:archive_path, ':h')
  if !isdirectory(l:archive_parent)
    call mkdir(l:archive_parent, 'p')
  endif
  
  " Move directory
  if rename(l:current_dir, l:archive_path) != 0
    echohl ErrorMsg
    echo "Failed to move directory to archive"
    echohl None
    return
  endif
  
  " Open the archived directory in netrw
  execute 'edit ' . fnameescape(l:archive_path)
  
  echohl MoreMsg
  echo "Archived directory: " . fnamemodify(l:archive_path, ':~')
  echohl None
endfunction

function! archiver#ArchiveHere()
  let l:current_path = expand('%:p')
  
  if empty(l:current_path)
    let l:current_path = getcwd()
  endif
  
  let l:is_file = filereadable(l:current_path)
  let l:is_dir = isdirectory(l:current_path)
  
  if !l:is_file && !l:is_dir
    echohl ErrorMsg
    echo "No valid file or directory"
    echohl None
    return
  endif
  
  " Get parent directory
  let l:parent = fnamemodify(l:current_path, ':h')
  let l:local_archive = l:parent . '/archive'
  
  " Build relative path
  let l:basename = fnamemodify(l:current_path, ':t')
  let l:archive_path = l:local_archive . '/' . l:basename
  
  " Create archive directory
  if !isdirectory(l:local_archive)
    call mkdir(l:local_archive, 'p')
  endif
  
  " Check if target already exists
  if filereadable(l:archive_path) || isdirectory(l:archive_path)
    echohl ErrorMsg
    echo "Target already exists in archive: " . l:archive_path
    echohl None
    return
  endif
  
  " Move file or directory
  if rename(l:current_path, l:archive_path) != 0
    echohl ErrorMsg
    echo "Failed to archive"
    echohl None
    return
  endif
  
  " Reopen at new location
  execute 'edit ' . fnameescape(l:archive_path)
  
  if l:is_file && g:archiver_readonly_archived
    setlocal readonly
  endif
  
  echohl MoreMsg
  echo "Archived to: " . fnamemodify(l:archive_path, ':~')
  echohl None
endfunction

function! archiver#Unarchive()
  let l:current_path = expand('%:p')
  
  if empty(l:current_path)
    let l:current_path = getcwd()
  endif
  
  let l:is_file = filereadable(l:current_path)
  let l:is_dir = isdirectory(l:current_path)
  
  if !l:is_file && !l:is_dir
    echohl ErrorMsg
    echo "No valid file or directory"
    echohl None
    return
  endif
  
  " Check if in archive
  let l:in_global_archive = s:IsInsidePath(l:current_path, g:archive_dir)
  let l:in_local_archive = s:IsInLocalArchive(l:current_path)
  
  if !l:in_global_archive && !l:in_local_archive
    echohl ErrorMsg
    echo "Not in an archive directory"
    echohl None
    return
  endif
  
  " Compute original path
  let l:original_path = ''
  if l:in_global_archive
    let l:original_path = s:ReverseArchivePath(l:current_path, g:archive_dir)
  else
    " Handle local archive
    let l:archive_pattern = '\(/archive/\)'
    let l:original_path = substitute(l:current_path, l:archive_pattern, '/', '')
  endif
  
  if empty(l:original_path)
    echohl ErrorMsg
    echo "Could not determine original path"
    echohl None
    return
  endif
  
  " Check if original path exists
  if filereadable(l:original_path) || isdirectory(l:original_path)
    echohl ErrorMsg
    echo "Original path already exists: " . l:original_path
    echohl None
    return
  endif
  
  " Create parent directories
  let l:original_parent = fnamemodify(l:original_path, ':h')
  if !isdirectory(l:original_parent)
    call mkdir(l:original_parent, 'p')
  endif
  
  " Move back
  if rename(l:current_path, l:original_path) != 0
    echohl ErrorMsg
    echo "Failed to unarchive"
    echohl None
    return
  endif
  
  " Reopen at original location
  execute 'edit ' . fnameescape(l:original_path)
  
  " Remove readonly
  if l:is_file
    setlocal noreadonly
  endif
  
  echohl MoreMsg
  echo "Unarchived to: " . fnamemodify(l:original_path, ':~')
  echohl None
endfunction

