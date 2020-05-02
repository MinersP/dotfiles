" https://github.com/huyvohcmc/dotfiles

" Faster loading
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python'
let g:ruby_host_prog = 'rvm system do neovim-ruby-host'

" Plugins will be downloaded under the specified directory
call plug#begin('~/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'justinmk/vim-sneak'
Plug 'itchyny/lightline.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mhinz/vim-signify' " Version control info on side
Plug 'scrooloose/nerdtree' " File Tree
Plug 'sheerun/vim-polyglot' " Language Pack
Plug 'tomtom/tcomment_vim' " Commenting stuff
Plug 'tpope/vim-fugitive' " Git plugin
Plug 'tpope/vim-repeat' " Adds additional use cases for '.' to repeat actions
Plug 'tpope/vim-rhubarb' " Github extension for vim-fugitive
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim' " Adds additional text objects to operate on
" Plug 'tpope/vim-endwise'
" Plug 'rstacruz/vim-closer'
Plug 'roxma/nvim-yarp'
Plug 'christoomey/vim-tmux-navigator'
Plug 'morhetz/gruvbox'
Plug 'ambv/black', { 'tag': '*' }
call plug#end()


" General settings (see :h vim-differences)
filetype plugin indent on
if !exists("termguicolors")
  set termguicolors
endif
set autoindent
set autoread
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set copyindent
set expandtab
set tabstop=2
set shiftwidth=0 " Always have the same value with `tabstop`
set softtabstop=-1 " Always have the same value with `shiftwidth`
set hidden
set history=500
set incsearch hlsearch ignorecase smartcase
set laststatus=2
set ignorecase smartcase
set lazyredraw
set linebreak
set list listchars=tab:.\ ,trail:.
set mouse=""
set nobackup
set nowritebackup
set noshowmatch
set noshowmode
set noswapfile
set number relativenumber
set ruler rulerformat=%l\:%c
set scrolloff=5
set shortmess+=c
set showcmd
set showtabline=1
set smarttab
set tags=./tags;,tags
set title
set wildmenu
set wildmode=list:longest,full
set wrap
set ttimeoutlen=0
set matchpairs+=<:>
set splitright
set modelines=0
set nomodeline
set cmdheight=2
set updatetime=300

" Safeguard
if !exists("g:syntax_on")
  syntax enable
endif

" Toggle relativenumber on mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

" Colorscheme
colorscheme gruvbox
set background=dark

" Vim sneak autocmd
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
let g:sneak#absolute_dir = 1
map f <Plug>Sneak_s
map F <Plug>Sneak_S
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" Leader general mapping
let mapleader = ","
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q!<cr>
nnoremap <leader>r :source ~/.config/nvim/init.vim<cr>
nnoremap <silent><leader><cr> :let @/ = ""<cr>
nnoremap <silent><right> :vertical resize +10<cr>
nnoremap <silent><left> :vertical resize -10<cr>
nnoremap <silent><up> :resize +10<cr>
nnoremap <silent><down> :resize -10<cr>

" Navigate properly when lines are wrapped
nnoremap j gj
nnoremap k gk

" NERDTree mapping and config
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>c :NERDTreeFind<CR>
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeHighlightCursorline = 0
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore = ['^\~$[[dir]]', '^\.o$[[file]]', '^\.pyc$[[file]]', '^\.DS_Store$[[file]]']

" FZF mapping
nnoremap <leader>h :History<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>t :Files<CR>

" The silver searcher
noremap <leader>ag <esc>:Ag<space>
noremap <leader>aw <esc>:Ag <c-r><c-w>
noremap <leader>ah <esc>:Ag<up><cr>

" Vim-fugitive and vim-rhubarb
noremap <silent> gb :Gblame<CR>
noremap <silent> ghub :Gbrowse<CR>

" Signify config
let g:signify_vcs_list = [ 'git' ]
let g:signify_realtime = 1
let g:signify_sign_show_count = 0
let g:signify_sign_change = '-'

" Gutentags exclude
let g:gutentags_exclude_project_root = ['/usr/local', '/Users/pminers']
let g:gutentags_ctags_exclude = ['*.min.js', '*.min.css', 'build', 'vendor', '.git', 'node_modules', '*.vim/bundle/*']

" LightLine config
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
let g:lightline.component_function = {
      \ 'cocstatus': 'coc#status',
      \ 'currentfunction': 'CocCurrentFunction',
      \ 'gitbranch': 'fugitive#head',
      \ }
let g:lightline.active = {
      \ 'left': [ [ 'mode', 'paste' ], [ 'cocstatus', 'currentfunction' ], [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ],
      \ }

" Python Black Settings
let g:black_fast = 1
let g:black_linelength = 88
autocmd BufWritePre *.py execute ':Black'

" COC Settings
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-python',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-vetur',
  \ ]
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  " imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

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

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" END of COC stuff

autocmd BufNewFile,BufRead *.installscript set syntax=scalk
