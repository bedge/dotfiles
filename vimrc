set encoding=utf-8
" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

" Change <Leader>
let mapleader = ","

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Make mouse work
set mouse=a

" https://github.com/ryanoasis/vim-devicons
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h14
" set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete:h12
" Linux replaces '/xx' with '\ xx'
"set encoding=utf8
" http://stackoverflow.com/questions/16507777/vim-set-encoding-and-fileencoding-utf-8
if !has('nvim') " https://github.com/carlhuda/janus/issues/633
	set encoding=utf-8  " The encoding displayed.
    "Modifyalb e is off errors:
    "set fileencoding=utf-8  " The encoding written to file
endif

" Mac's VimR only
if has("gui_vimr")
" Here goes some VimR specific settings like
    " no-op, instead of a 'pass'
	set encoding=utf-8  " The encoding displayed.
else
    " vimr has menu preferences.
    set guifont=HackNerdFontComplete-Regular:h12
endif


let g:airline_powerline_fonts = 1

set background=dark
" Color scheme
"colorscheme solarized
"colorscheme solarized

" https://medium.com/@ericclifford/neovim-item2-truecolor-awesome-70b975516849#.8q343liop
" Old way
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" New way
if has("nvim")
  set termguicolors
endif 

let g:gruvbox_italic=1
let g:gruvbox_invert_signs=1
"let g:gruvbox_improved_strings=1
let g:gruvbox_improved_warnings=1

colorscheme gruvbox

"let g:jellybeans_use_term_italics = 1
"colorscheme jellybeans

"colorscheme sourcerer
"highlight NonText guibg=#060606
"highlight Folded  guibg=#0A0A0A guifg=#9090D0

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set wrapscan      " Searches wrap around end of the file.
set ignorecase
set smartcase
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set cursorline    " highlight the current line the cursor is on
set diffopt+=vertical

" Make it obvious where 132 characters is
set textwidth=132
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

"sm:    flashes matching brackets or parentheses
set showmatch

" Softtabs, 2 spaces
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Hightlight tabs
set hlsearch


" Display extra whitespace
"set list listchars=tab:»·,trail:·,nbsp:·

"sta:   helps with backspacing because of expandtab
set smarttab

" When scrolling off-screen do so 3 lines at a time, not 1
set scrolloff=3

" Enable tab complete for commands.
" first tab shows all matches. next tab starts cycling through the matches
set wildmenu
set spelllang=en_us

" Fugitive status
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    let python_highlight_all=1
    syntax on

endif

filetype plugin indent on
" Clean up wrap/indent display
"set breakindent

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=sh
  autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
  autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
  autocmd BufRead,BufNewFile vimrc.local set filetype=vim
augroup END

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
  
  autocmd BufRead,BufNewFile *.conf set filetype=cfg

augroup END

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Ggrep
  set grepprg=ag\ --nogroup\ --nocolor
  "Below from ag manpage
  "set grepprg=ag\ --vimgrep\ $* set grepformat=%f:%l:%c:%m
  " bind K to grep word under cursor
  " No, conflicts with scriptease
  "  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

  " bind \ (backward slash) to grep shortcut
  "command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"" Tags
"
"set tags=./tags;~/git

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
let g:autotagTagsFile="tags"
map <f12> :!ctags -R .<cr>
" https://andrew.stwrt.ca/posts/vim-ctags/
" nnoremap <leader>P :CtrlPTag<cr>
nnoremap <C-S-P>  :CtrlPTag<cr>
nnoremap <C-p>  :CtrlP<cr>
nnoremap <silent> <Leader>b :TagbarToggle<CR>
" http://majutsushi.github.io/tagbar/
nmap <F8> :TagbarToggle<CR>

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }

" https://github.com/scrooloose/syntastic
" https://github.com/vim-syntastic/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_python_checkers = ['pep8']
let g:syntastic_python_pep8_args='--ignore=E501,E225,E241,E221'

" https://github.com/vim-syntastic/syntastic/issues/341
let g:syntastic_always_populate_loc_list = 1

let g:ctrlp_extensions = ['tag']
let g:ctrlp_show_hidden = 1
nnoremap <leader>w :SyntasticCheck<CR>:w<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Open the Rails ApiDock page for the word under cursor, using the 'open'
" command
let g:browser = 'open '

function! OpenRailsDoc(keyword)
  let url = 'http://apidock.com/rails/'.a:keyword
  exec '!'.g:browser.' '.url
endfunction

" Open the Ruby ApiDock page for the word under cursor, using the 'open'
" command
function! OpenRubyDoc(keyword)
  let url = 'http://apidock.com/ruby/'.a:keyword
  exec '!'.g:browser.' '.url
endfunction

" NERDTree
let NERDTreeQuitOnOpen=1
" colored NERD Tree
let NERDChristmasTree = 1
let NERDTreeHighlightCursorline = 1
let NERDTreeShowHidden = 1
" map enter to activating a node
let NERDTreeMapActivateNode='<CR>'
let NERDTreeIgnore=['\.git','\.DS_Store','\.pdf', '.beam', '.pyc$']

" https://github.com/scrooloose/nerdtree/issues/433#issuecomment-92590696
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('gradle', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('java', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('py', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('yaml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('env', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('sh', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('properties', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" java completer
" https://github.com/artur-shaik/vim-javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete
" To enable smart (trying to guess import option) inserting class imports with F4, add:
autocmd FileType java nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
autocmd FileType java imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
" To enable usual (will ask for import option) inserting class imports with F5, add:
autocmd FileType java nmap <F5> <Plug>(JavaComplete-Imports-Add)
autocmd FileType java imap <F5> <Plug>(JavaComplete-Imports-Add)
" To add all missing imports with F6:
autocmd FileType java nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
autocmd FileType java imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
" To remove all missing imports with F7:
autocmd FileType java nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
autocmd FileType java imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)

" Set tags for vim-fugitive
set tags^=.git/tags

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

"" Shortcuts!!

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Tab navigation
nmap <space> gt

" Remap F1 from Help to ESC.  No more accidents.
nmap <F1> <Esc>
map! <F1> <Esc>
" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <c-p> :Files<cr>

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" <leader>F to begin searching with ag
map <leader>F :Ag<space>

" search next/previous -- center in page
nmap n nzz
nmap N Nzz
nmap * *Nzz
nmap # #nzz

" Capital Y yanks to clipboard
"noremap Y "+y
" https://evertpot.com/osx-tmux-vim-copy-paste-clipboard/
set clipboard=unnamed

" Easily lookup documentation on apidock
noremap <leader>rb :call OpenRubyDoc(expand('<cword>'))<CR>
noremap <leader>rr :call OpenRailsDoc(expand('<cword>'))<CR>

" Easily spell check
" http://vimcasts.org/episodes/spell-checking/
nmap <silent> <leader>s :set spell!<CR>

" Added by Leo

" Switch into background mode
nnoremap <leader>. <C-z>

" Git shortcut
map <leader>g :Git<space>

" Move between splits
"nnoremap <S-Tab> <C-W>W
"nnoremap <Tab> <C-W><C-W>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L> 
nnoremap <C-H> <C-W><C-H>

"nmap <S-Up> v<Up>
"nmap <S-Down> v<Down>
"nmap <S-Left> v<Left>
"nmap <S-Right> v<Right>
"vmap <S-Up> <Up>
"vmap <S-Down> <Down>
"vmap <S-Left> <Left>
"vmap <S-Right> <Right>

" Paste mode in and out
nnoremap <leader>p :set paste<CR>
nnoremap <leader>np :set nopaste<CR>

" Nerdtree
"map <C-n> :NERDTreeToggle<CR>
" https://github.com/jistr/vim-nerdtree-tabs
" map <C-n> :NERDTreeTabsToggle<CR>
" No, conflicts with selecta mapping
"map <Leader>n <plug>NERDTreeTabsToggle<CR>
map <leader>t :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup=0


" JJ escape
inoremap jj <ESC>

:au FocusLost * :wa

"save and run last command
nnoremap <CR> :wa<CR>:!!<CR>

"open vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

"make ctrl-c work with vim on a mac
vnoremap <C-c> :w !pbcopy<CR><CR> noremap <C-v> :r !pbpaste<CR><CR>

autocmd FileType javascript inoremap (; ();<Esc>hi
set autowrite

set shell=$SHELL

" RSpec.vim mappings
"map <Leader>t :call RunCurrentSpecFile()<CR>
"map <Leader>s :call RunNearestSpec()<CR>
"map <Leader>l :call RunLastSpec()<CR>
"map <Leader>a :call RunAllSpecs()<CR>

" such very magic
":nnoremap / /\v
:cnoremap %s/ %s/\v

" Indentation
nnoremap == gg=G``
nnoremap <Leader>i gg=G``

" Get off my lawn
"nnoremap <Left> :echoe "Use h"<CR>
"nnoremap <Right> :echoe "Use l"<CR>
"nnoremap <Up> :echoe "Use k"<CR>
"nnoremap <Down> :echoe "Use j"<CR>
"inoremap <Left> Use h
"inoremap <Right> Use l
"inoremap <Up> Use k
"inoremap <Down> Use j


" Convert to ruby 1.9 hash
nnoremap <Leader>H :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>

nnoremap <leader>q <C-w>q
nnoremap <leader>w :StripWhitespace<CR>
map zx :wqa<CR>

" Toggle paste mode
nnoremap <leader>p :set invpaste paste?<CR>
imap <leader>p <C-O>:set invpaste paste?<CR>
set pastetoggle=<leader>p

" Move up and down by visual line
nnoremap j gj
nnoremap k gk

" Relative line number toggle
let g:NumberToggleTrigger="<leader>r"

" Pomodoro
"nmap <leader>T :!thyme -d<CR><CR>

"nnoremap <C-o> o<Esc>
"nnoremap <C-O> O<Esc>

" Hard times
let g:hardtime_default_on = 0
nnoremap <leader>h :HardTimeToggle<CR>
let g:hardtime_timeout = 900
let g:hardtime_showmsg = 1
let g:hardtime_maxcount = 2

" Run feature tests
"nnoremap <leader>f :!clear && echo "Running all feature tests" && rspec features<CR>

nnoremap <leader>vs :so $MYVIMRC <CR>:VundleInstall <CR>:q <CR> :echo "Vimrc has been reloaded"<CR>
nnoremap <leader>S :so $MYVIMRC<CR> :echo "Vimrc has been reloaded"<CR>

" Convert html to haml
nmap <leader><leader>h :%!html2haml --erb 2> /dev/null<CR>:set ft=haml<CR>
vmap <leader><leader>h :!html2haml --erb 2> /dev/null<CR>

" Automatically run a file
function! RunWith (command)
  execute "w"
  execute "!clear; " . a:command . " " . expand("%")
endfunction

autocmd FileType ruby nnoremap <leader>q :call RunWith("ruby")<CR>
autocmd FileType javascript nnoremap <leader>q :call RunWith("node")<CR>
autocmd FileType python nnoremap <leader>q :call RunWith("python")<CR>

" Put a single line cursor in insert mode
" https://gist.github.com/andyfowler/1195581
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" https://github.com/airblade/vim-rooter/issues/30
let g:rooter_patterns = ['.git/', '.git', 'Rakefile', 'Gemfile', 'Berksfile']

" Map date string to F2
map <F2> a<C-R>=strftime("%D")<CR><Esc>

" Bernhardt strikes again...selecta

" ^W to delete the word before the cursor
" ^H to delete the character before the cursor
" ^U to delete the entire line
" ^N to select the next match
" ^P to select the previous match
" ^C to quit without selecting a match
"
" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<cr>

" https://github.com/garybernhardt/selecta/blob/master/EXAMPLES.md

" Fuzzy select a buffer. Open the selected buffer with :b.
function! SelectaBuffer()
  let bufnrs = filter(range(1, bufnr("$")), 'buflisted(v:val)')
  let buffers = map(bufnrs, 'bufname(v:val)')
  call SelectaCommand('echo "' . join(buffers, "\n") . '"', "", ":b")
endfunction

nnoremap <leader>b :call SelectaBuffer()<cr>

" Search for files based on identifier under the cursor
function! SelectaIdentifier()
  " Yank the word under the cursor into the z register
  normal "zyiw
  " Fuzzy match files in the current directory, starting with the word under
  " the cursor
  call SelectaCommand("find * -type f", "-s " . @z, ":e")
endfunction

nnoremap <c-g> :call SelectaIdentifier()<cr>

" Don't collapse json quotes, makes it too jumpy
" set conceallevel=0

" code folding
set foldmethod=syntax
set foldlevelstart=20
nnoremap <space> za
" http://vim.wikia.com/wiki/All_folds_open_when_opening_a_file
" Note, perl automatically sets foldmethod in the syntax file
autocmd Syntax c,cpp,vim,xml,html,xhtml,py,java,json setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,py,java,json normal zR

" Multiple highlight, "Mark" plugin config.
" http://www.vim.org/scripts/script.php?script_id=2666
" let g:mwDefaultHighlightingPalette = 'extended'
let g:mwDefaultHighlightingPalette = 'maximum'
" Avoid binding conflicts
nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev

let g:mwIgnoreCase = 0
nmap <Leader>M <Plug>MarkToggle
" nmap <Leader>N <Plug>MarkAllClear
nmap <Leader>N <Plug>MarkConfirmAllClear


" https://github.com/Chiel92/vim-autoformat
noremap <F3> :Autoformat<CR>

let g:formatter_yapf_style = 'pep8'
"let g:formatter_json_style = 'js-beautify'

" .cf = .json
au BufRead,BufNewFile *.cf		setfiletype json
au BufRead,BufNewFile Jenkinsfile	setfiletype groovy

au BufRead,BufNewFile *.deckspec	setfiletype yaml

" pep8
au BufNewFile,BufRead *.py;
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css;
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4
autocmd Filetype yaml setlocal expandtab tabstop=2 shiftwidth=2

let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
"python with virtualenv support
"if !has('nvim') " https://github.com/carlhuda/janus/issues/633
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
  "project_base_dir = os.environ['VIRTUAL_ENV']
  "activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  "execfile(activate_this, dict(__file__=activate_this))
"EOF
"" Above is python 2 only
"" Virtualenv support

""else
""py3 << EOF
""import os
""import sys
""if 'VIRTUAL_ENV' in os.environ:
  ""project_base_dir = os.environ['VIRTUAL_ENV']
  ""activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  ""exec(compile(open(activate_this, "rb").read(), activate_this, 'exec'), dict(__file__=activate_this))
""EOF
"endif

" help provider-python
" let g:python_host_prog = '/Users/bedge/Virtualenvs/p2/bin/python'

" https://github.com/junegunn/vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ---------------------------------- "
" Configure YouCompleteMe
" ---------------------------------- "

let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']

" Goto definition with F3
map <F4> :YcmCompleter GoTo<CR>
map <F5> :YcmCompleter GetDoc<CR>

" https://github.com/christoomey/vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <M-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <M-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <M-Right> :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" Neovim tmux movement integration
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>


" Plugin 'JamshedVesuna/vim-markdown-preview'
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=1
let vim_markdown_preview_hotkey='<C-m>'

" Autosave
let g:session_autosave = 'no'
let g:session_autoload = 'no'

" Resizing automation
" http://zhaocai.github.io/GoldenView.Vim/
" 1. split to tiled windows
nmap <silent> <C-L>  <Plug>GoldenViewSplit

" 2. quickly switch current window with the main pane
" and toggle back
nmap <silent> <F8>   <Plug>GoldenViewSwitchMain
nmap <silent> <S-F8> <Plug>GoldenViewSwitchToggle

" 3. jump to next and previous window
nmap <silent> <C-N>  <Plug>GoldenViewNext
nmap <silent> <C-P>  <Plug>GoldenViewPrevious

" But, disable it for now until I get better at using it...
let g:goldenview__enable_at_startup = 0

" https://github.com/majutsushi/tagbar
nmap <F9> :TagbarToggle<CR>

" Make diff colors less revolting
source ~/.vim/colors/diff-colorscheme.vim

