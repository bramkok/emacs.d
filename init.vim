"start
function! Start()
  let g:names='^[-gmnq]\=vim\=x\=\%[\.exe]$'
  if argc() || line2byte('$') != -1 || v:progname !~? g:names || &insertmode
    return
  endif
  enew
endfun
autocmd VimEnter * call Start() " Runs after startup

"mappings
map <Space> <Leader>
noremap <Leader>w    :w<CR>
noremap <Leader>q    :q<CR>
noremap <Leader>sp   :sp<CR>
noremap <Leader>vsp  :vsp<CR>
noremap <Leader>rl   :SourceRC<CR>
noremap <Leader><CR> :nohlsearch<CR>
noremap q :bn<CR>
noremap Q :bp<CR>
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

"plugins
let g:has_plug=0
if isdirectory(glob('~/.config/nvim/plug'))
  let g:has_plug=1
  call plug#begin('~/.config/nvim/plug')
    Plug 'editorconfig/editorconfig-vim'
    Plug 'tpope/vim-abolish'
    Plug 'chriskempson/base16-vim'
    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
    Plug 'leafgarland/typescript-vim', { 'for': 'javascript' }
    Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
    Plug 'peitalin/vim-jsx-typescript', { 'for': 'javascript' }
    Plug 'styled-components/vim-styled-components',
        \ { 'branch': 'main', 'for': 'javascript' }
    Plug 'maxmellon/vim-jsx-pretty', { 'for': 'javascript' }
      let g:vim_jsx_pretty_colorful_config = 1
    Plug 'tpope/vim-commentary'
      noremap <Leader>cc :Commentary<CR>
    Plug 'scrooloose/nerdtree'
      noremap <Leader>n :NERDTreeToggle<CR>
      let NERDTreeMinimalUI=1
    Plug 'ntpeters/vim-better-whitespace'
      autocmd BufEnter * EnableStripWhitespaceOnSave
      let g:strip_whitespace_on_save = 1
      let g:strip_whitespace_confirm = 0
    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf.vim'
      let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
      nnoremap <silent> <C-p> :FZF<CR>
      nnoremap <silent> <C-b> :Buffer<CR>
      autocmd VimEnter * command! -nargs=* Ag call fzf#vim#ag (
        \ <q-args>, '--skip-vcs-ignores', fzf#vim#default_layout)
    Plug 'tmux-plugins/vim-tmux'
    Plug 'christoomey/vim-tmux-navigator'
      let g:tmux_navigator_no_mappings = 1
      nnoremap <silent> <C-a>h :TmuxNavigateLeft<CR>
      nnoremap <silent> <C-a>j :TmuxNavigateDown<CR>
      nnoremap <silent> <C-a>k :TmuxNavigateUp<CR>
      nnoremap <silent> <C-a>l :TmuxNavigateRight<CR>
    Plug 'airblade/vim-gitgutter'
      nnoremap <Leader>ggp :GitGutterPrevHunk<CR>
      nnoremap <Leader>ggn :GitGutterNextHunk<CR>
      nnoremap <Leader>ggs :GitGutterStageHunk<CR>
      nnoremap <Leader>ggt :GitGutterToggle<CR>
      let g:gitgutter_sign_column_always = 0
      let g:gitgutter_override_sign_column_highlight = 0
      let g:gitgutter_enabled = 1
      let g:gitgutter_sign_added = '┃'
      let g:gitgutter_sign_modified = '┃'
      let g:gitgutter_sign_removed = '┃'
      let g:gitgutter_sign_removed_first_line = '┃'
      let g:gitgutter_sign_modified_removed = '┃'
      hi link GitGutterAdd          DiffAdd
      hi link GitGutterChange       DiffChange
      hi link GitGutterDelete       DiffDelete
      hi link GitGutterChangeDelete DiffDelete
  call plug#end()
endif

"colors
syntax on
if filereadable(expand("~/.config/nvim/colorscheme.vim")) && has_plug
  let base16colorspace=256
  source ~/.config/nvim/colorscheme.vim
endif
hi NonText ctermfg=0

"general
set relativenumber clipboard+=unnamed,unnamedplus
set expandtab shiftwidth=2 autoindent smartindent formatoptions=jcql
set noswapfile noerrorbells novisualbell
set linebreak nolist listchars=tab:..,trail:.
set showcmd cursorline
set scrolloff=3 lazyredraw mouse=a
set undofile udir=~/.config/nvim/undo
if has('nvim')
else
  scriptencoding utf-8
  set autoindent autoread backspace=indent,eol,start complete-=i
  set display=lastline encoding=utf-8 formatoptions=tcqj history=10000 hlsearch
  set incsearch langnoremap laststatus=2 listchars=tab:>\ ,trail:-,nbsp:+
  set mouse=a nrformats=hex sessionoptions-=options smarttab tabpagemax=50
  set tags=./tags;,tags ttyfast viminfo+=! wildmenu
  hi NonText ctermfg=234
endif

"commands
command! -nargs=* SourceRC so $MYVIMRC
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
autocmd VimResized * wincmd =
autocmd FileType * setlocal formatoptions-=cro
autocmd TermOpen * setlocal nonumber norelativenumber

"statusline
set statusline=
set statusline+=%1*\ %{expand('%:h')}/
set statusline+=%2*%t\ %*
set statusline+=%<
set statusline+=%3*
set statusline+=%{(&modified?'+\ ':'')}
set statusline+=%*
set statusline+=%=
set statusline+=%4*
set statusline+=\ %c
set statusline+=\.%l\

"wildignore
set wildignore=
set wildignore+=*/.git/*,*/.svn/*,*.DS_Store,*/undo/*
set wildignore+=*/nginx_runtime/*,*/build/*,*/logs/*,*/dist/*,*/tmp/*
set wildignore+=*/.bundle/*,*/.gems/*,*/.sass-cache/*,*/db/*,*/elm-stuff/*
set wildignore+=*/node_modules/*,*/tmp/*,*/vendor/*,*/_site/*,*/build/*
set wildignore+=*/coverage/*,*/dist/*,*/public/*,*/www/*,*/cache/*
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.log,*.pyc,*.sqlite,*.sqlite3,*.min.js,*.min.css,*.tags
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.pdf,*.dmg,*.app,*.ipa,*.apk,*.mobi,*.epub
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.doc,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
