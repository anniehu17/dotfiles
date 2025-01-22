" Auto reload .vimrc on save
augroup AutoReloadVimRC
	au!
	au BufWritePost $MYVIMRC so $MYVIMRC
augroup END

""" WORKSPACE """

set background=dark
" Enable syntax highlighting
syntax on
" Display cursor position
set ruler
" Display line numbers
set number
" Show incomplete command as you type it
set showcmd
" Wrap lines
set wrap
" Set scrolloffset so cursor doesn't hit the bottom of the screen
set so=4
" Highlight current line
set cursorline
hi CursorLine cterm=NONE ctermbg=239
" Highlight current column
set cursorcolumn
hi CursorColumn term=reverse ctermbg=239
let g:airline_theme='base16_monokai'

" Show full file path
let g:airline_section_c = '%F'

" 20 cmd history, 1000 marks in a file, 100 search patterns
set viminfo='20,<1000,s100

" Show matched pairs
set showmatch

function! ToggleComment()
" define filetype to comment sequence dictionary
let ft_to_comment_seq = {
   \ 'conf': '#',
   \ 'c': '//',
   \ 'cpp': '//',
   \ 'make': '#',
   \ 'java': '//',
   \ 'python': '#',
   \ 'sh': '#',
   \ 'vim': '"',
   \ 'tmux': '#',
   \ }

    " set comment_seq based on filetype
    let ft = &filetype 
    let comment_seq = ft_to_comment_seq['cpp'] " default to //
    if has_key(ft_to_comment_seq, ft)
        let comment_seq = ft_to_comment_seq[ft]
    endif

    " if the line starts with a comment + space
    if getline(".") =~ "^" . comment_seq . " "
        " replace start of line + comment + space with empty string 
        execute "s/^" . comment_seq . " //"
    " if the line starts with a comment and no space
    elseif getline(".") =~ "^" . comment_seq
        " replace start of line + comment with empty string
        execute "s/^" . comment_seq . "//"
    elseif empty(getline("."))
        " replace start of line with comment
        " TODO: we might want to uncomment empty lines though
        execute "s/^/" . comment_seq . "/"
    else
        " replace start of line with comment + space
        execute "s/^/" . comment_seq . " /"
    endif

endfunction

" Ctrl + / in normal mode (or visual mode for multiple lines at a time)
map <C-_> :call ToggleComment()<CR>

""" WINDOWS """

" enable the mouse
set mouse=a

" enable window resizing by dragging the mouse and smoother selection
if has('mouse_sgr')
    set ttymouse=sgr
elseif &term =~ '^screen'
    set ttymouse=xterm2
endif

" make current split more obvious with a different colored status bar
hi StatusLine term=bold cterm=bold ctermbg=4

" make current split more obvious by toggling the cursor row and column
augroup PositionToggle
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinEnter * set cursorcolumn
    autocmd WinLeave * set nocursorline
    autocmd WinLeave * set nocursorcolumn
augroup END

" easier movement between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" easier escape during insert mode
inoremap kj <ESC>

" easier movement between tabs
noremap <C-N> :<C-U>tabnext<CR>
noremap <C-P> :<C-U>tabprevious<CR>

""" NAVIGATION """

" Most navigation wraps around the screen (including in insert mode)
set whichwrap=b,s,h,l,<,>,[,]

" angle brackets are usually matched.
set matchpairs+=<:>

" navigate faster
nnoremap J 10j
nnoremap K 10k
vnoremap J 10j
vnoremap K 10k

" ^ and $ are hard to reach
noremap H ^
noremap L $

" merge is the only useful thing lost from the above remappings
nnoremap M J

""" COMMANDS """

" nicer menu during command-line completion
set wildmenu

" do not just match the first filename, go for longest match then ask for more
set wildmode=longest:full

""" EDITING """

" disable letting ctrl-a increment a number (b/c tmux)
map <C-A> <Nop>

""" STYLE """

" lines should not exceed 80 characters
set colorcolumn=80
highlight ColorColumn ctermbg=yellow ctermfg=black guibg=yellow

highlight OverLength ctermbg=red ctermfg=white guibg=red
match OverLength /\%81v.\+/

" do not want trailing whitespace
highlight ExtraWhitespace ctermbg=blue guibg=blue
match ExtraWhitespace /\s\+$/

" remove all trailing whitespace
nnoremap qw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:noh<CR>

""" SEARCH """

" ignore case in search
set ignorecase

" ... unless we specify case
set smartcase

" highlight search results
set hlsearch
hi Search ctermbg=239 ctermfg=208

" make search act like search in modern browers
set incsearch

" search file for visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
