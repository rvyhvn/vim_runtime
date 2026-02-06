if exists('g:loaded_archiver')
  finish
endif
let g:loaded_archiver = 1

" Configuration
if !exists('g:archive_dir')
  let g:archive_dir = expand('~/Documents/para/archives')
endif

if !exists('g:archiver_file_limit')
  let g:archiver_file_limit = 1000
endif

if !exists('g:archiver_readonly_archived')
  let g:archiver_readonly_archived = 1
endif

augroup ArchiverReadonly
  autocmd!
  autocmd BufRead,BufNewFile * if expand('%:p') =~# escape(g:archive_dir, '\') | setlocal readonly nomodifiable | endif
augroup END

" Commands
command! ArchiveNote call archiver#ArchiveNote()
command! ArchiveDir call archiver#ArchiveDir()
command! ArchiveHere call archiver#ArchiveHere()
command! Unarchive call archiver#Unarchive()

