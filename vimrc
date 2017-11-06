set nu
:syntax on
:filetype plugin on
":nnoremap ,t :CommandT<CR>
let g:CommandTCancelMap='<C-x>'
"call pathogen#infect()

" airline config
set laststatus=2
let g:airline_section_x = '%{airline#util#prepend(airline#extensions#tagbar#currenttag(),0)}'
let g:airline_section_y = ''
let g:airline_section_warning = ''
"set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

map q :q!<CR>
" map g :wq<CR>
map z :w<CR>
map t !} fmt -65<CR>
map T !} fmt -78<CR>
map <C-n>       :tn<CR>
map <C-p>       :tp<CR>
map <F1> <Esc>
:nmap <F10> :TagbarToggle<CR> 
:nmap <F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ .<CR>

:map [[ ?{<CR>w99[{
:map ][ /}<CR>b99]}
:map ]] j0[[%/{<CR>
:map [] k$][%?}<CR>


"set ai
"set ic
set hlsearch
set incsearch
set notitle
set ruler
set textwidth=79

" Tab-size is 4 for .thpl files.
"
"au BufNewFile,BufRead *.thpl set ts=4
"au BufNewFile,BufRead *.cpp,*.cc set expandtab
"
" Use 4-space tabs
"
set expandtab
set shiftwidth=4
set softtabstop=4
"set mouse=n

map <C-\>n :set noai<CR>i
map <C-\>N :set ai<CR>

"map <C-\>o /^>>>> ORIGINAL\\|^==== THEIRS\\|^==== YOURS\\|^<<<<<CR>

"
" Perforce shortcuts
"
"map <C-\>p :!px edit %<CR><CR>
"map <C-\>r :!px revert %<CR><CR>

"
" Enable 256-color support
"
set t_Co=256

"
" Box the block whose end is marked with 'a' tag.
" Mark the beginning of the block with 'z' tag.
"
let @m = "mz0i/------------------------------------------------------------:.,'as/^/| /o\\------------------------------------------------------------"

"
" Box the block to the end of the file.
" Mark the beginning of the block with 'z' tag.
"
let @e = "mz0i/------------------------------------------------------------:.,$s/^/| /o\\------------------------------------------------------------"

"
" Box to the end of the paragraph.
" Mark the beginning of the block with 'z' tag.
"
let @p = "mz0i/------------------------------------------------------------:.,/^$/s/^/| /R\\------------------------------------------------------------"

" allows for backspace of items not inserted in this "insert session"
set backspace=2

if has("syntax")
"	if strlen($XTERM_SHELL) == 0
"		" modified the entry for Statement in syncolor.vim file
"		" from Yellow to brown to make it look better in 256-color
"		" xterm.  The file is in /usr/share/vim/vim70/syntax.
"	endif
	syntax on
	command -nargs=0 Setbrown highlight Statement ctermfg=brown
	command -nargs=0 Setyellow highlight Statement ctermfg=yellow
endif

"function! FancyStatusLine()
"    let g:ctags_statusline=1
"    let g:ctags_path='/usr/bin/ctags'
"    let g:ctags_args='-I __declspec+'
"    let g:generate_tags = 1
"    source $HOME/.vim/plugin/ctags.vim
"    set statusline=%<%t\ %h%m%r\ \ %<%{GetTagName(line(\".\"))}%=%-20.(%l/%L,%c%V%)\ %P
"endfunction

"
" Settings based on the file extention
"
au BufNewFile,BufRead *.cpp,*.cc,*.c,*.h,*.sh set fo+=rco
au BufNewFile,BufRead *.cpp,*.cc,*.c,*.h,*.sh set smartindent
"au BufNewFile,BufRead *.cpp,*.cc,*.c,*.h,*.sh : call FancyStatusLine()

" Highlight any text past column 80 in red.
highlight LineError80 ctermfg=DarkRed
:function CheckLine()
:	match LineError80 /\%>80v.\+/
:endfunction

" Disable long line highlighting
:function NoCheckLine()
:	match LineError80 /\%>4096v.\+/
:endfunction

:augroup programming
:	autocmd BufEnter *.cpp,*.h    :call CheckLine()
:	autocmd BufLeave *.cpp,*.h    :call NoCheckLine()
:	autocmd BufEnter *.c,*.cc,*.s    :call CheckLine()
:	autocmd BufLeave *.c,*.cc,*.s    :call NoCheckLine()
:	autocmd BufEnter *.d,*.x,*.idl,*.ndl :call CheckLine()
:	autocmd BufLeave *.d,*.x,*.idl,*.ndl :call NoCheckLine()
:augroup end

"
" cscope settings
"
if has("cscope")
        set csto=1
        set cst
        set nocsverb
	if filereadable("cscope.out")
		cs add cscope.out
	endif
        "set csverb
	if v:version >= 602
		"
		" Enable using quickfix for cscope
		"
		nmap <C-q>- :set cscopequickfix=s-,d-,c-,t-,e-,f-,i-

		"
		" Disable using quickfix for cscope
		"
		nmap <C-q>0 :set cscopequickfix=s0,d0,c0,t0,e0,f0,i0

		"
		" The following commands open a sub-window for showing the
		" symbols that cscope finds.
		"
		"cab co copen
		"cab cc cclose
		"nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR><TAB>
		"nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR><TAB>
		"nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR><TAB>
		"nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR><TAB>
	endif

    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'd'   called: find functions that function under cursor calls
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
	
	map <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	map <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	map <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
	map <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	map <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	map <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	map <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	map <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
        
        
        "nmap <C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
        nmap <C-@>s :tab scs find s <C-R>=expand("<cword>")<CR><CR>
        nmap <C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
        nmap <C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
        nmap <C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
        nmap <C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
        nmap <C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
        nmap <C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>   
        nmap <C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR> 


	map <C-/>s :cs find s 
	map <C-/>g :cs find g 
	map <C-/>d :cs find d 
	map <C-/>c :cs find c 
	map <C-/>t :cs find t 
	map <C-/>e :cs find e 
	map <C-/>f :cs find f 
	map <C-/>i :cs find i 

endif

"
" vimdiff settings
"
if &diff
	map q :qa<CR>

	" x229_Wheat1 for changed line
	highlight DiffChange ctermbg=229 ctermfg=16
	" x092_DarkViolet for changed text
	highlight DiffText ctermbg=92 ctermfg=255
	" x112_Chartreuse2 for added lines
	highlight DiffAdd ctermbg=112 ctermfg=16
	" dark red for deleted lines
	highlight DiffDelete ctermbg=1 ctermfg=16
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle spelling
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:spell_enable = 0

function! g:ToggleSpell()
	if g:spell_enable == 0
		setlocal spell spelllang=en_us
		let g:spell_enable = 1
	else
		let g:spell_enable = 0
		set nospell
	endif
endfunction

" <C-@> means Ctrl+Space
"nmap <C-@>s :call g:ToggleSpell()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle mouse
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mouse_enable = 0

function! g:Togglemouse()
	if g:mouse_enable == 0
		set mouse=a
		let g:mouse_enable = 1
	else
		let g:mouse_enable = 0
		set mouse=""
	endif
endfunction

nmap <F9> :call g:Togglemouse()<CR>

"
" CallTree Plugin
"
let g:CCTreeKeyTraceForwardTree = '<C-e>' 
let g:CCTreeKeyTraceReverseTree = '<C-h>' 
map <C-l>s :CCTreeLoadDB cscope.out<CR>
map <C-s>x :CCTreeSaveXRefDB cctree.out<CR>
map <C-l>x :CCTreeLoadXRefDB cctree.out<CR>

"
" OmniCppComplete Plugin
"
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview


" My shortcuts
:map <C-h> :noh <Enter>
:map <C-a> :w <Enter>
:map <C-c> :wq! <Enter>

:nmap <F5> :tabnext<CR>
:nmap <F4> :tabprev<CR>
:nmap <F3> :Texplore<CR> 

" - Visual Mode shortcuts
:vnoremap qq <Esc>`>a*/<Esc>`<i/*<Esc>
:vnoremap ss <Esc>`>a'''<Esc>`<i'''<Esc>
:vnoremap g/ y/<C-R>"<CR>

" SHORTCUTS
" ===============================================
"
" CTRL
" -----------------------------------------------
" Ctrl + ] - jump into 
" Ctrl + t - jump back
" Ctrl + o - jump undo
" Ctrl + f - page down
" Ctrl + b - page up
"
"
" SHIFT Shortcuts
" ------------------------------------------------
" 3. Shift + #  - highlight word
" 4. Shift + $  - Move to end of line
" 5. Shift + %  - Highlight matching bracket
" 6. Shift + ^  - Move to begining of word
" 8. Shift + *  - search word without typing
"
" :Texplore     - handy method to navigate in dir
"
" Search without Keyboard
" --------------------------------------------------
" Ctrl +V (selected the text) - Yank (y) - Go to search bar - / Ctrl + R + "  - paste in shell
" 
" Plugin
" -------------------------------------------------
" NERDTree - handy plugin - doesn't list hidden files
" Powerline
" Youcompleteme
"
" Miscellaneous
" --------------
" :noh  - remove search highlight
" [m    - jump to beginning of the function
" ]m    - jump to end of the function
"
" Using marks
" --------------------
" ma - 'a   - lower case - file specific
" mA - 'A   - inter file 
" :marks    - list markers
" :delmarks - delete marks
" :delmarks a
"
" Visual Mode 
" ----------------------
" Ctrl + V (select); Shift + i (insert); <put comments>; <esc> 
"
" vi -t <Function name> - integration with cscope


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set runtimepath^=~/.vim/bundle/ctrlp.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
Plugin 'user/L9', {'name': 'newL9'}

Plugin 'Lokaltog/vim-powerline'
Plugin 'The-NERD-tree'
call vundle#end()            " required
filetype plugin indent on    " required


set nocompatible
filetype indent plugin on
syntax on
set hidden
set wildmenu
set showcmd
set hlsearch    " Highlight searched item
set ignorecase  " Case insensitive search
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set t_Co=256
set confirm
set visualbell
set t_vb=
set cmdheight=1
set number
set notimeout ttimeout ttimeoutlen=200
set shiftwidth=4
set softtabstop=4
set expandtab
set noswapfile  " Do not generate Swap files"
map Y y$
