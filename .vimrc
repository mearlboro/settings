" Directives for use with: https://github.com/bronson/vim-update-bundles
" https://raw.github.com/bronson/vim-update-bundles/master/vim-update-bundles
" Bundle: https://github.com/ctrlpvim/ctrlp.vim.git
" Bundle: https://github.com/MarcWeber/vim-addon-mw-utils.git
" Bundle: https://github.com/morhetz/gruvbox
" Bundle: https://github.com/altercation/vim-colors-solarized.git
" Bundle: https://github.com/bling/vim-airline.git
" Bundle: https://github.com/junegunn/vim-easy-align
" Bundle: tpope/vim-pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" :W sudo saves the file 
" (for handling the permission-denied error)
command W w !sudo tee % > /dev/null


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set n lines to the cursor - when moving vertically using j/k
set so=10

" Fix stupid paste aka set bracketed paste
set paste

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Always show line numbers
set nu

" Height of the command bar
set cmdheight=2

" Configure backspace to go over newlines and wrap
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Show matching brackets when text indicator is over them
set showmatch

" Make <> act like brackets, bounce with %
set matchpairs+=<:>

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Mark trailing whitespace
match TODO /\s\+$/


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Make verymagic default for perl-style regex
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %s/\v
cnoremap >s/ >s/\v
nnoremap :g/ :g/\v


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Themes, colors, fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Enable 256 colors palette
set t_Co=256

" Set bg and custom colorscheme
set background=dark
let g:solarized_termcolors=256
colorscheme gruvbox
let g:gruvbox_contrast='medium'

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac
set fileformat=unix

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Mark trailing whitespace
match Todo /\s\+$/
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Indent/outdent to nearest tabstop
set shiftround

" 1 tab = 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 100 characters
set lbr
set tw=100

" Display margin for 80 characters
set textwidth=80

set ai   "Auto indent
set si   "Smart indent
set wrap "Wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight repeated lines
fun! HighlightRepeats() range
  let lineCounts = {}
  let lineNum = a:firstline
  while lineNum <= a:lastline
    let lineText = getline(lineNum)
    if lineText != ""
      let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
    endif
    let lineNum = lineNum + 1
  endwhile
  exe 'syn clear Repeat'
  for lineText in keys(lineCounts)
    if lineCounts[lineText] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfun

" Delete trailing white space on save
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

" Remap the tab key to do autocompletion or indentation depending on the
" context (from http://www.vim.org/tips/tip.php?tip_id=102)
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Airline, add nice symbolic fonts
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
