" Generals
set number
set relativenumber
set clipboard=unnamedplus
set cursorline
set mouse=a
set colorcolumn=80
colorscheme gruber-darker
let g:gruvbox_termcolors=256
let g:python3_host_prog="/home/hanshi/.pyenv/versions/nvim-env/bin/python3"
let g:loaded_netrw=1
map <leader>q :e /tmp/buffer<cr>
" set guicursor=i:block
filetype plugin indent on
autocmd BufWinEnter * highlight Cursor ctermfg=yellow ctermbg=yellow
autocmd InsertEnter * hi iCursor ctermfg=yellow ctermbg=yellow
" highlight iCursor ctermfg=yellow ctermbg=yellow
syntax on
set shiftwidth=2 et
set tabstop=2
set encoding=utf-8
" True color if available
let term_program=$TERM_PROGRAM
set t_Co=256
" Check for conflicts with Apple Terminal app
if term_program !=? 'Apple_Terminal'
    set termguicolors
else
    if $TERM !=? 'xterm-256color'
        set termguicolors
    endif
endif

let mapleader=","


" Enable blinking together with different cursor shapes for insert/command mode, and cursor highlighting:
  set guicursor=n-v-c-i:block
  \,a:blinkwait20-blinkoff50-blinkon200-Cursor/lCursor
  \,sm:block-blinkwait20-blinkoff20-blinkon20

  " Check for HTML embedded filetype as HTML
autocmd BufNewFile,BufRead *.ezt,*.blade.php,*.erb, *.fxml set filetype=html

" transparent bg
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
" For Vim<8, replace EndOfBuffer by NonText
autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE

" Pathogen
let g:pathogen_blacklist = ['vim-snipmate', 'vim-snippets']
let g:pathogen_disabled = ['vim-snipmate', 'vim-snippets', 'nerdtree']

" Rainbow Brackets
let g:rainbow_active = 1
let g:rainbow_conf = {
\    'guifgs': ['#E06C75', '#ffff00', '#61AFEF', '#D19A66', '#98C379', '#C678DD', '#56B6C2'],
\    'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\    'guis': [''],
\    'cterms': [''],
\    'operators': '_,_',
\    'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\    'separately': {
\        '*': {},
\        'markdown': {
\            'parentheses_options': 'containedin=markdownCode contained', 
\        },
\        'lisp': {
\            'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'], 
\        },
\        'haskell': {
\            'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'], 
\        },
\        'vim': {
\            'parentheses_options': 'containedin=vimFuncBody', 
\        },
\        'perl': {
\            'syn_name_prefix': 'perlBlockFoldRainbow', 
\        },
\        'stylus': {
\            'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'], 
\        },
\        'css': 0,
\        'htmldjango': 0,
\    }
\}

" NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
"    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif


" let g:NERDTreeDirArrowExpandable = '↪'
" let g:NERDTreeDirArrowCollapsible = '↯'
" autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
let g:NERDTreeHijackNetrw = 0


" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'startify']
let g:indent_guides_auto_colors = 1
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 2
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=white
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=grey

" COC
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" inoremap <silent><expr> <c-space> coc#refresh()
" " Make <CR> to accept selected completion item or notify coc.nvim to format
" " <C-g>u breaks current undo, please make your own choice.
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" function! CheckBackspace() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " Use `[g` and `]g` to navigate diagnostics
" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
" nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
" nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)

" " GoTo code navigation COC
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Use K to show documentation in preview window
" nnoremap <silent> K :call ShowDocumentation()<CR>

" function! ShowDocumentation()
"   if CocAction('hasProvider', 'hover')
"     call CocActionAsync('doHover')
"   else
"     call feedkeys('K', 'in')
"   endif
" endfunction

" " Highlight the symbol and its references when holding the cursor
" autocmd CursorHold * silent call CocActionAsync('highlight')
" " Symbol renaming COC
" nmap <leader>rn <Plug>(coc-rename)
" " Remap keys for applying refactor code actions
" nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
" xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
" nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" " Map function and class text objects
" " NOTE: Requires 'textDocument.documentSymbol' support from the language server
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)

" " Remap <C-f> and <C-b> to scroll float windows/popups
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" let g:coc_filetype_map = {'tex': 'latex'}

" Vim Icons
" let g:webdevicons_enable_nerdtree = 1
" let g:webdevicons_conceal_nerdtree_brackets = 1
" let g:webdevicons_enable_unite = 1
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vue'] = '󰡄'


" vim-startify
" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
" function! s:gitModified()
"     let files = systemlist('git ls-files -m 2>/dev/null')
"     return map(files, "{'line': v:val, 'path': v:val}")
" endfunction

" same as above, but show untracked files, honouring .gitignore
" function! s:gitUntracked()
"     let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
"     return map(files, "{'line': v:val, 'path': v:val}")
" endfunction

" let g:startify_lists = [
"         \ { 'type': 'files',     'header': ['   MRU']            },
"         \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
"         \ { 'type': 'sessions',  'header': ['   Sessions']       },
"         \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
"         \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
"         \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
"         \ { 'type': 'commands',  'header': ['   Commands']       },
"         \ ]


" Keymappings
" nnoremap j k
" nnoremap k j
nnoremap <leader>a ggVG
nnoremap <C-S-A-Down> Vyp
nnoremap <C-S-A-Up> VyP

nnoremap <M-h> :vertical resize-2<CR>
nnoremap <M-l> :vertical resize+2<CR>
" Open config file
" nnoremap <leader>c :tabnew ~/.vim_runtime/my_configs.vim<CR>
" nnoremap <leader>c :execute 'tabnew ' . expand('~/.vim_runtime/my_configs.vim')<CR>

" Commentary
vnoremap <leader>/ :Commentary<CR>
nnoremap <leader>// :Commentary<CR>

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'], ['fugitive'],
      \             [ 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo', 'percent'], ['fileformat', 'fileencoding', 'filetype'], ['blame'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*FugitiveHead")?FugitiveHead():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*FugitiveHead") && ""!=FugitiveHead())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' },
      \ 'component_function': {
      \   'blame': 'LightlineGitBlame',
      \ },
  \ }

let g:lightline.tabline = {
      \ 'left': [ ['buffers'] ],
      \ 'right': [ ['close'] ]
      \ }

let g:lightline.component_expand = {
      \ 'buffers': 'lightline#bufferline#buffers',
      \ 'close': 'lightline#bufferline#close',
      \ }

let g:lightline.component_type = {
      \ 'buffers': 'tabsel',
      \ 'close': 'raw',
      \ }

set showtabline=2
set tabline=%!lightline#tabline()


" Vimtex
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_latexmk_engines = {
  \ '_' : '-xelatex',
  \}

" Dirvish
let g:dirvish_mode = ':sort | sort ,^.*[^/]$, r'

" ------------------------
" Basic Vim LSP setup
" ------------------------

" Completion behavior
set completeopt=menuone,noinsert,noselect,preview
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_auto_popup = 1

" Language servers
let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server', 'deno']

" Diagnostics
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 0

" UI helpers
let g:lsp_preview_float = 1
let g:lsp_signature_help_enabled = 0

" Close preview window after completion
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Completions
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)
" For Vim 8 (<c-@> corresponds to <c-space>):
" imap <c-@> <Plug>(asyncomplete_force_refresh)

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" ------------------------
" LSP buffer setup
" ------------------------
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

    " Navigation + actions
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)

    " Format on save
    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre <buffer> call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


" OLD LSP
" " Vim LSP
" let g:asyncomplete_auto_completeopt = 1

" let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server', 'deno']

" " set completeopt=menuone,noinsert,noselect,preview
" set completeopt=menuone,noinsert
" let g:lsp_diagnostics_virtual_text_enabled = 0
" let g:lsp_diagnostics_echo_cursor = 1
" let g:lsp_diagnostics_float_cursor = 1
" let g:lsp_preview_float = 0
" let g:lsp_signature_help_enabled = 0

" " LSP toggle state
" let g:lsp_enabled = 0

" " Toggle LSP function
" function! ToggleLSP()
"   if g:lsp_enabled
"     " Disable LSP features
"     let g:asyncomplete_auto_completeopt = 0
"     let g:asyncomplete_auto_popup = 0
"     set completeopt=menuone,noinsert
"     let g:lsp_diagnostics_virtual_text_enabled = 0
"     let g:lsp_diagnostics_float_cursor = 1
"     let g:lsp_diagnostics_echo_cursor = 1
"     let g:lsp_preview_float = 0
"     let g:lsp_signature_help_enabled = 0
"     let g:lsp_enabled = 0
"     echo "LSP features disabled"
"   else
"     " Enable LSP features (restore original settings)
"     let g:asyncomplete_auto_completeopt = 1
"     let g:asyncomplete_auto_popup = 1
"     set completeopt=menuone,noinsert,preview
"     let g:lsp_diagnostics_virtual_text_enabled = 0
"     let g:lsp_diagnostics_float_cursor = 1
"     let g:lsp_diagnostics_echo_cursor = 1
"     let g:lsp_preview_float = 1
"     let g:lsp_signature_help_enabled = 1
"     let g:lsp_enabled = 1
"     echo "LSP features enabled"
"   endif
" endfunction

" " Map to <leader>l
" nnoremap \l :call ToggleLSP()<CR>

" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" " Completions
" inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
" imap <c-space> <Plug>(asyncomplete_force_refresh)
" " For Vim 8 (<c-@> corresponds to <c-space>):
" " imap <c-@> <Plug>(asyncomplete_force_refresh)
" let g:asyncomplete_auto_popup = 0
" function! s:check_back_space() abort
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~ '\s'
" endfunction

" inoremap <silent><expr> <TAB>
"   \ pumvisible() ? "\<C-n>" :
"   \ <SID>check_back_space() ? "\<TAB>" :
"   \ asyncomplete#force_refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


" " allow modifying the completeopt variable, or it will
" " be overridden all the time

" function! s:on_lsp_buffer_enabled() abort
"     setlocal omnifunc=lsp#complete
"     setlocal signcolumn=yes
"     if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"     nmap <buffer> gd <plug>(lsp-definition)
"     nmap <buffer> gs <plug>(lsp-document-symbol-search)
"     nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
"     nmap <buffer> gr <plug>(lsp-references)
"     nmap <buffer> gi <plug>(lsp-implementation)
"     nmap <buffer> gt <plug>(lsp-type-definition)
"     nmap <buffer> <leader>rn <plug>(lsp-rename)
"     nmap <buffer> [g <plug>(lsp-previous-diagnostic)
"     nmap <buffer> ]g <plug>(lsp-next-diagnostic)
"     nmap <buffer> K <plug>(lsp-hover)
"     " nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
"     " nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

"     let g:lsp_format_sync_timeout = 1000
"     autocmd! BufWritePre * call execute('LspDocumentFormatSync')
" endfunction

" augroup lsp_install
"     au!
"     " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"     autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END

" augroup LspAutoFormat
"   autocmd!
"   autocmd BufWritePre * call s:maybe_lsp_format()
" augroup END

" function! s:maybe_lsp_format() abort
"   if !empty(lsp#get_allowed_servers())
"     silent! LspDocumentFormat
"   endif
" endfunction
" if executable('clangd')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'clangd',
"         \ 'cmd': {server_info->['clangd', '-background-index']},
"         \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
"         \ })
" endif

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

" call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
"     \ 'name': 'buffer',
"     \ 'allowlist': ['*'],
"     \ 'blocklist': ['go'],
"     \ 'completor': function('asyncomplete#sources#buffer#completor'),
"     \ 'config': {
"     \    'max_buffer_size': 5000000,
"     \  },
"     \ }))

" if executable('pyls')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'pyls',
"         \ 'cmd': {server_info->['pyls']},
"         \ 'whitelist': ['python'],
"         \ 'workspace_config': {'pyls': {'plugins': {'pydocstyle': {'enabled': v:true}}}}
"         \ })
"   endif

" FZF
function! s:fzf_next(idx)
  let commands = ['Files', 'Rg', 'Buffers']

  " launch the command
  execute commands[a:idx]

  " calculate next and previous indices
  let next = (a:idx + 1) % len(commands)
  let previous = (a:idx - 1 + len(commands)) % len(commands)

  " set buffer-local mappings for cycling inside fzf
  execute 'tnoremap <buffer> <silent> <C-f> <C-\><C-n>:close<CR>:sleep 100m<CR>:call <sid>fzf_next('.next.')<CR>'
  execute 'tnoremap <buffer> <silent> <C-b> <C-\><C-n>:close<CR>:sleep 100m<CR>:call <sid>fzf_next('.previous.')<CR>'
endfunction

" entry point: start with the first one
nnoremap <C-f> :call <SID>fzf_next(0)<CR>

" vsnip

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']

" img-paste
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
" there are some defaults for image directory and image name, you can change them
let g:mdip_imgdir = 'assets'
let g:mdip_imgname = 'image'

" ================================
" Zettelkasten.vim configuration
" ================================

let g:zettelkasten_path = '~/Documents/notes'
let g:zettelkasten_daily_notes = v:true
let g:zettelkasten_format = '{{timestamp}}-{{slug}}'
let g:zettelkasten_orphan_exclude_dirs = ['journal', 'daily', 'templates', 'archive']

" --- Templates ---
" Global template directory
let g:zettelkasten_template_dir = expand('~/Templates/zettelkasten')

" Resolution order:
"   1. <workspace>/.templates/<type>.md
"   2. global template dir/<type>.md
"   3. default.md
"
" Types: <workspace>.md, zettel.md, daily.md

" --- Frontmatter ---
" Toggle YAML frontmatter
let g:zettelkasten_frontmatter = v:true

" Define fields. Values expand placeholders.
let g:zettelkasten_template_frontmatter = {
      \ 'daily': {
      \   'id': '{{title}}',
      \ },
      \ 'meeting': {
      \   'title': '{{title}}',
      \   'date': '{{date}}',
      \   'attendees': '[]',
      \   'type': 'meeting',
      \   'tags': '[meeting]',
      \ },
      \ 'book': {
      \   'title': '{{title}}',
      \   'author': '',
      \   'isbn': '',
      \   'rating': '',
      \   'tags': '[book]',
      \ },
      \ }

let g:zettelkasten_frontmatter_fields = {
      \ 'id': '{{timestamp}}-{{slug}}',
      \ 'title': '{{title}}',
      \ 'date': '{{date}}',
      \ 'aliases': '[{{title}}]',
      \ 'tags': '[]',
      \ }

nnoremap <leader>zn :ZetNew<CR>
nnoremap <leader>zd :ZetDaily<CR>
nnoremap <leader>zt :ZetTemplates<CR>
nnoremap <leader>zo :ZetOrphans<CR>
nnoremap <leader>zf :ZetNotes<CR>
nnoremap <leader>zc :ZetConfig<CR>
nnoremap <leader>zl :call zettelkasten#follow_link_enhanced()<CR>

command! Notes call zettelkasten#fzf_notes()

" imgpaste.vim
let g:imgpaste_imgbb_api = "b69c8f588bd3848d019177727bbfc330"
let g:imgpaste_ft_markdown = '![]($IMG$)'
let g:imgpaste_ft_html = '<img src="$IMG$" alt="$NAME$">'
let g:imgpaste_ft_tex = '\includegraphics[width=\linewidth]{$IMG$}'

lua << EOF
require('mini.move').setup()
EOF


