function! s:get_pattern(ft) abort
  let l:varname = 'g:imgpaste_ft_' . a:ft
  if exists(l:varname)
    return eval(l:varname)
  endif
  " fallback
  return '$IMG$'
endfunction

function! imgpaste#paste() abort
  if empty(g:imgpaste_imgbb_api)
    echohl ErrorMsg | echom "imgpaste: g:imgpaste_imgbb_api not set" | echohl None
    return
  endif

  let l:tmp = tempname() . ".png"

  " --- Grab clipboard image into tmp file ---
  if executable("pngpaste")
    let l:grab = "pngpaste " . shellescape(l:tmp)
  elseif executable("wl-paste")
    let l:grab = "wl-paste --type image/png > " . shellescape(l:tmp)
  elseif executable("xclip")
    let l:grab = "xclip -selection clipboard -t image/png -o > " . shellescape(l:tmp)
  else
    echohl ErrorMsg | echom "imgpaste: no clipboard image tool found" | echohl None
    return
  endif

  call system(l:grab)
  if v:shell_error
    echohl ErrorMsg | echom "imgpaste: failed to grab image" | echohl None
    return
  endif

  " --- Insert placeholder text ---
  let l:nonce = reltimefloat(reltime())
  let l:placeholder = "Upload In Progress... " . l:nonce
  execute "normal! i" . l:placeholder

  " --- Prepare async state ---
  let l:state = {'buf': [], 'placeholder': l:placeholder, 'tmp': l:tmp}
  let l:name = imgpaste#randstr(8)
  let l:cmd = [
        \ 'curl', '-s',
        \ '-F', 'image=@' . l:tmp,
        \ '-F', 'name=' . l:name,
        \ 'https://api.imgbb.com/1/upload?key=' . g:imgpaste_imgbb_api
        \ ]

  call async#job#start(l:cmd, {
        \ 'on_stdout': {j,d,e->extend(l:state.buf, d)},
        \ 'on_exit':   {j,c,e->imgpaste#done(join(l:state.buf, "\n"), l:state.placeholder, l:state.tmp)}
        \ })
endfunction

function! imgpaste#done(output, placeholder, tmp) abort
  try
    let l:resp = json_decode(a:output)
    if has_key(l:resp, 'data') && has_key(l:resp.data, 'url')
      let l:url = l:resp.data.url
      let l:id = get(l:resp.data, 'id', '')
      let l:title = get(l:resp.data, 'title', '')

      " decide which one you want to treat as filename
      let l:filename = !empty(l:title) ? l:title : l:id

      let l:pattern = s:get_pattern(&filetype)
      let l:line = substitute(l:pattern, '\$IMG\$', l:url, 'g')
      let l:line = substitute(l:line, '\$NAME\$', l:id, 'g')

      execute '%s/' . escape(a:placeholder, '/\') . '/' . escape(l:line, '/\') . '/g'
    else
      echohl ErrorMsg | echom "imgpaste: upload failed" | echohl None
    endif
  catch
    echohl ErrorMsg | echom "imgpaste: invalid response: " . a:output | echohl None
  endtry

  call delete(a:tmp)
endfunction

function! imgpaste#randstr(len) abort
  let chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
  let out = ''
  for i in range(a:len)
    let out .= chars[rand() % len(chars)]
  endfor
  return out
endfunction
