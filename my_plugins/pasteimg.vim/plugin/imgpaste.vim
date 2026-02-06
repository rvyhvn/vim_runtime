if !exists("g:imgpaste_imgbb_api")
  let g:imgpaste_imgbb_api = ""
endif

if !exists("g:imgpaste_ft_markdown")
  let g:imgpaste_ft_markdown = '![$NAME$]($IMG$)'
endif

if !exists("g:imgpaste_ft_html")
  let g:imgpaste_ft_html = '<img src="$IMG$" alt="$NAME$">'
endif

if !exists("g:imgpaste_ft_tex")
  let g:imgpaste_ft_tex = '\includegraphics[width=\linewidth]{$IMG$}'
endif


command! ImgPaste call imgpaste#paste()
