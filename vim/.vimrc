"--------------------------------------------------
" System setup
"--------------------------------------------------
set exrc
set hidden
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set cmdheight=2
set updatetime=50
set isfname+=@-@
set belloff=all

"--------------------------------------------------
" Plugin support
"--------------------------------------------------

call plug#begin('~/vimfiles/plugged')
" User interface
Plug 'christoomey/vim-tmux-navigator'
Plug 'lilydjwg/colorizer'
Plug 'rosenfeld/conque-term'
Plug 't9md/vim-choosewin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'ryanoasis/vim-devicons'
Plug 'frazrepo/vim-rainbow'
Plug 'farmergreg/vim-lastplace'
Plug 'preservim/nerdtree'
" Themes
Plug 'dracula/vim', {'name': 'dracula'}
Plug 'morhetz/gruvbox'
Plug 'colepeters/spacemacs-theme.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'phanviet/vim-monokai-pro'
Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/base16-vim'
" Language support
Plug 'tmhedberg/SimpylFold'
Plug 'jiangmiao/auto-pairs'
Plug 'Townk/vim-autoclose'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'Shougo/context_filetype.vim'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-pathogen'
Plug 'sheerun/vim-polyglot'
Plug 'jeetsukumaran/vim-indentwise'
" Python support
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'
Plug 'himkt/docstring.nvim'
Plug 'jupyter-vim/jupyter-vim'
Plug 'lambdalisue/jupyter-vim-binding'
Plug 'cjrh/vim-conda'
Plug 'sbdchd/neoformat'
Plug 'neomake/neomake'
" Latex support
Plug 'lervag/vimtex'
" Markdown
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'godlygeek/tabular'
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'iamcco/markdown-preview.nvim', {'do': {-> mkdp#util#instal() }}
" Todo
Plug 'vitalk/vim-simple-todo'
Plug 'fisadev/FixedTaskList.vim'
" Code completion
Plug 'neoclide/coc.nvim'
Plug 'davidhalter/jedi-vim'
" Search
Plug 'junegunn/fzf', {'dir': '~/vimfiles/fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'kien/ctrlp.vim'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/IndexedSearch'
" Edit functions
Plug 'tpope/vim-surround'
Plug 'vim-scripts/YankRing.vim'
" Git support
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
" Snippet support
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Debbuger support
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
" Cheat Sheet
Plug 'dbeniamine/cheat.sh-vim'

call plug#end()

"--------------------------------------------------
" System setup
"--------------------------------------------------
set nocompatible
filetype plugin on
filetype indent on
set ls=2
set incsearch
set hlsearch
syntax on

" General setup
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set encoding=utf-8
set signcolumn=yes
set colorcolumn=80
set number
set relativenumber
set clipboard=unnamed
set shortmess+=c
set completeopt=menuone,longest
set guicursor=
set scrolloff=7
set backspace=indent,eol,start
set wildmenu
set wildmode=full

set termguicolors
colorscheme gruvbox-material

" Flagging unncessary whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
autocmd BufRead,BufNewFile * match BadWhitespace /\s\+$/
autocmd FileType * call rainbow#load()

" Remove whitespace before saving
autocmd BufWritePre * :%s/\s\+$//e

" disable autocomment in newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"--------------------------------------------------
" General key mapping
"--------------------------------------------------
" toggle relative numbering
nnoremap <leader>r :set relativenumber!<cr>

" move up and down the block
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

vnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

inoremap <C-c> <esc>
" insert blank line
nnoremap <S-Enter> O<esc>
nnoremap <cr> o<esc>
" clear search results
nnoremap <silent> // :noh<cr>

" mappings to previous, next buffer
nnoremap <leader>1 :bp<cr>
nnoremap <leader>2 :bn<cr>

"--------------------------------------------------
" Language support
"--------------------------------------------------

" Pathogen
execute pathogen#infect()

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

" CoC: Conquer of Completion
" Define which extensions are required
"let g:coc_global_extensions=['coc-bibtex', 'coc-fzf-preview' ,
"            \ 'coc-jedi', 'coc-json', 'coc-markdownlint',
"            \ 'coc-marketplace', 'coc-powershell',
"            \ 'coc-vimlsp', 'coc-vimtex', 'coc-xml', 'coc-diagnostic',
"            \ 'coc-highlight', 'coc-lists', 'coc-pyright',
"            \ 'coc-snippets', 'coc-spell-checker', 'coc-sql',
"            \ 'coc-yank']
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Make <cr> auto-select the first completion item and notify coc.nvim to
" foramt on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"
" Use [g and ]g to navigate diagnostics
" Use :CocDiagnostics to get all diagnostics of current buffer in location list.
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnositc-next)
" GoTo code navigation
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<cr>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming
nnoremap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xnoremap <leader>f <Plug>(coc-format-selected)
nnoremap <leader>f <Plug>(coc-format-selected)

augroup CoCgroup
    autocmd!
    " Setup formatexpr specified filetype(s)
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END
" Applying codeActio to the selected region.
" Example: <leader>aap for the current paragraph
xnoremap <leader>a <Plug>(coc-codeaction-selected)
nnoremap <leader>a <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer
nnoremap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nnoremap <leader>qf <Plug>(coc-fix-current)
" Map function and class text objects
" NOTE: Requires 'TextDocuemnt.documentSymbol' support from the language server
xnoremap if <Plug>(coc-funcobj-i)
onoremap if <Plug>(coc-funcobj-i)
xnoremap af <Plug>(coc-funcobj-a)
onoremap af <Plug>(coc-funcobj-a)
xnoremap if <Plug>(coc-classobj-i)
onoremap if <Plug>(coc-classobj-i)
xnoremap af <Plug>(coc-classobj-a)
onoremap af <Plug>(coc-classobj-a)
" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<cr>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<cr>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<cr>

" Fix to let ESC work as expected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert mode)
" let g:AutoClosePumvisible = {'ENTER': '\<C-Y>', 'ESC': '\<ESC>'}

"--------------------------------------------------
" Python support
"--------------------------------------------------
" Python custom setup
autocmd BufNewFile,BufRead *.py
            \ set tabstop=4 |
            \ set softtabstop=4 |
            \ set shiftwidth=4 |
            \ set expandtab |
            \ set autoindent |
            \ set fileformat=unix
" Run linter on write
autocmd! BufWritePost * Neomake
" Check code as python3 by default
let g:neomake_python_python_maker = neomake#makers#ft#python#python()
let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
let g:neomake_python_python_maker.exe = 'python3 -m py_compile'
let g:neomake_python_flake8_maker.exe = 'python3 -m flake8'
" Disable error messages inside the buffer, next to the problematic line
let g:neomake_virtualtext_current_error=0
let g:neomake_python_enabled_makers=['pylint', 'flake8', 'pep8']
let g:neomake_python_autopep8={
            \ 'exe': 'autopep8',
            \ 'args': ['-s 4', '-E'],
            \ 'replace': 1,
            \ 'stdin': 1,
            \ 'env': ["DEBUG=1"],
            \ 'valid_exit_code': [0, 23],
            \ }
let g:neoformat_enabled_python = ['autopep8']
" Autoformat
let g:neoformat_basic_format_align=1
let g:neoformat_basic_format_retab=1
let g:neoformat_basic_format_trim=1
" Syntax highlighting
let python_highlighting_all=1

"--------------------------------------------------
" Markdown support
"--------------------------------------------------
" Disable header folding
let g:vim_markdown_folding_disabled=1
" Do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal=0
" Disable math TeX conceal feature
let g:tex_conceal=''
let g:vim_markdown_math=1
" Support front matter of various format
let g:vim_markdown_frontmatter=1 " for YAML format
let g:vim_markdown_toml_frontmatter=1 " for TOML format
let g:vim_markdown_json_frontmatter=1 " for JSON format
augroup pandoc_syntax
    autocmd! BufNewFile,BufFilePre,BufRead *.md filetype=markdown.pandoc
augroup END
" Do not close the preview tab when switching to other buffers
let g:mkdp_auto_close=0750

nnoremap <M-m> :MarkdownPreview<cr>

"--------------------------------------------------
" LaTeX support
"--------------------------------------------------

"--------------------------------------------------
" IDE Configuration
"--------------------------------------------------

" Folding ----------
set foldmethod=indent
set foldlevel=99
" Show docstring for folded code
let g:SimplyFold_docstring_preview=1
nnoremap <space> za

" NERDCommenter ----------
nnoremap <C-_> <Plug>NERDCommenterToggle
vnoremap <C-_> <Plug>NERDCommenterToggle<cr>gv

" NERDTree ----------
" ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$', '\.pyo$']
let NERDTreeQuitOnOpen=1
" let g:NERDTreeMinimalUI=1
nnoremap <leader>n :NERDTreeToggle<cr>
" open nerdtree with the current file selected
nnoremap ,t :NERDTreeFind<cr>
" Enable folder icons
let g:WebDevIconsUnicodeDecorateFolderNodes=1
let g:DevIconsEnableFoldersOpenClose=1
" Fix directory colors
highlight! link NERDTreeFlags NERDTreeDir
" Remove expandable arrow
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
let NERDTreeNodeDelimiter = "\x07"
" Autorefresh on tree focus
function! NERDTreeRefresh()
  if &filetype == "nerdtree"
      silent exe substitute(mapcheck("R"), "<cr>", "", "")
  endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

" Airline setup ----------
let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled=1 " Smarter tab line
let g:airline#extensions#tabline#fnamemode=':t' " Show only names
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
let g:airline#extensions#whitespace#enabled=1
" Fancy Symbols!!
let g:webdevicons_enable = 0

let g:yankring_history_dir='~/vimfiles/dirs/'

" Tab navigation ----------
noremap tt :tabnew
noremap <M-l> :tabn<cr>
inoremap <M-l> <esc>:tabn<cr>
noremap <M-l> :tabn<cr>
inoremap <M-l> <esc>:tabn<cr>

" Tagbar ----------
noremap <leader>t :TagbarToggle<cr>
let g:tagbar_autofocus=1 " autofocus on tagbar open
" TaskList ----------
" show pending tasks lists
noremap <leader>T <Plug>TaskList
let g:tlWindowPosition=1
let g:tlRememberPosition=1

"--------------------------------------------------
" FZF support
"--------------------------------------------------
" file finder mapping
nnoremap ,e :Files<cr>
" tags (symbols) in current file finder mapping
nnoremap ,g :BTag<cr>
" the same, but with the word under the cursor pre filled
nnoremap ,wg :execute ":BTag " . expand('<cword>')<cr>
" tags (symbols) in all files finder mapping
nnoremap ,G :Tags<cr>
" the same, but with the word under the cursor pre filled
nnoremap ,wG :execute ":Tags " . expand('<cword>')<cr>
" general code finder in current file mapping
nnoremap ,f :BLines<cr>
" the same, but with the word under the cursor pre filled
nnoremap ,wf :execute ":BLines " . expand('<cword>')<cr>
" general code finder in all files mapping
nnoremap ,F :Lines<cr>
" the same, but with the word under the cursor pre filled
nnoremap ,wF :execute ":Lines " . expand('<cword>')<cr>
" commands finder mapping
nnoremap ,c :Commands<cr>

"--------------------------------------------------
" Git support
"--------------------------------------------------

" Fugitive ----------
" Fugitive conflict resolution
nnoremap <leader>gd :Gvdiff<cr>
nnoremap gdh :diffget //2<cr>
nnoremap gdl :diffget //3<cr>

" Signify ----------
" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = ['git']
" mappings to jump to changed blocks
nnoremap <leader>sn <plug>(signify-next-hunk)
nnoremap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

"--------------------------------------------------
" Snippets
"--------------------------------------------------

" UltiSnips ----------
let g:UltiSnipsExpandTrigger='<leader><tab>'
let g:UltiSnipsJumpForwardTrigger='<C-b>'
let g:UltiSnipsJumpBackwardTrigger='<C-z>'
" If you want :UltiSnipsEdit to split your window
let g:UltiSnipsEditSplit='vertical'

" Coc-Snippets ----------
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
" Make <tab> used for trigger completion, completion confirm, snippet expand,
" and jump like VSCode
inoremap <silent><expr> <tab>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<cr>" :
      \ <SID>check_back_space() ? "\<tab>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

