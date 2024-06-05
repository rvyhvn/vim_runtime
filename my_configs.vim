" Generals
set number
set relativenumber
set clipboard=unnamedplus
set cursorline
set mouse=a
colorscheme gruvbox
let g:gruvbox_termcolors=256
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
" autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
" For Vim<8, replace EndOfBuffer by NonText
autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE

" Pathogen
let g:pathogen_blacklist = ['vim-snipmate', 'vim-snippets']
let g:pathogen_disabled = ['vim-snipmate', 'vim-snippets']

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
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
   \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif


let g:NERDTreeDirArrowExpandable = '↪'
let g:NERDTreeDirArrowCollapsible = '↯'
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'startify']
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=white
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=grey

" COC
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation COC
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming COC
nmap <leader>rn <Plug>(coc-rename)
" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

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
nnoremap j k
nnoremap k j
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

" let g:lightline = {
"       \ 'colorscheme': 'nord',
"       \ 'active': {
"       \   'left': [ ['mode', 'paste'], ['fugitive'],
"       \             [ 'readonly', 'filename', 'modified'] ],
"       \   'right': [ [ 'lineinfo', 'percent'], ['fileformat', 'fileencoding', 'filetype'], ['blame'] ]
"       \ },
"       \ 'component': {
"       \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
"       \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
"       \   'fugitive': '%{exists("*FugitiveHead")?FugitiveHead():""}'
"       \ },
"       \ 'component_visible_condition': {
"       \   'readonly': '(&filetype!="help"&& &readonly)',
"       \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
"       \   'fugitive': '(exists("*FugitiveHead") && ""!=FugitiveHead())'
"       \ },
"       \ 'separator': { 'left': ' ', 'right': ' ' },
"       \ 'subseparator': { 'left': ' ', 'right': ' ' },
"       \ 'component_function': {
"       \   'blame': 'LightlineGitBlame',
"       \ }
"   \ }

" Vimtex
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexmk'
