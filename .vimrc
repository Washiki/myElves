"Color Schemes :
"    retrobox 
"    afterglow //external
"    seoul256 //external 
"    slate
"    sorbet 
"    habamax

"the vars of the plugin must be set before its loaded. 
let g:vimtex_view_method = 'general' "general just allows to call the general viewer, which you can pass with params (which we need_
let g:vimtex_view_general_viewer = 'wslview'" this passes to the windows file viewers. 
"let g:vimtex_view_general_viewer = 'xdg-open'" 
let g:vimtex_view_general_options = '' "this is the param that had to be passed, because im opening the windows pdf viewer 
"Everything works, but i can't get vimtex to open the file by itself. 

"remapping the leader. IMportant. 
let g:mapleader = ","

" NEOCLIDE 
"this function mplements the nice backspace autocomplete
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"tab is autocomplete 
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

"prevoius key is Shift + tab, good to know 
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" EMMET 
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
" <c-y> to expand emmet

" random shit area 
"call popup_notification("Hi Washiki!", #{ line: 1, col: 1, time: 3000 })
"call just calls a function. how is it different from au? au also gets
"triggers and keypresses automated. 

call popup_create(["Yahallo","Washiki!"],{'time': 3000,'border':[],'close':'button', 'line' : 1, 'col' : &columns - 10})


"&columns is the terminal viewwidth

" random shit area ends 

"this calls the plugins
call plug#begin('~/.vim/plugged')

"for the bad times. 
"Plug 'github/copilot.vim'

"intellisense implement, it seems to be fine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"rainbow fart 
Plug 'Washiki/rainbow-fart.vim'

"token highlighting 
Plug 'RRethy/vim-illuminate'

"Markdown support
Plug 'preservim/vim-markdown'  

"Telescope like fuzzy finding
Plug 'junegunn/fzf'

"Clipboard functionality. I mean registers work but yes 
Plug 'svermeulen/vim-easyclip'

"surrounding stuff. better for surround. tags
Plug 'machakann/vim-sandwich'
"emmet
Plug 'mattn/emmet-vim'

"Fast comment. Tim pope himself built a better one. 
Plug 'tpope/vim-commentary'

"color highlighting
Plug 'ap/vim-css-color'

"noncompatible on steroids 
Plug 'tpope/vim-sensible'

"Git. In vim. Tim pop my man.
Plug 'tpope/vim-fugitive'

"Git changes 
Plug 'airblade/vim-gitgutter'

"random theme i like 
Plug 'junegunn/seoul256.vim'

"LATEX IN VIM JUST LIKE THAT ONE MATH TUT
Plug 'lervag/vimtex'

"sidebar file explorer , b etter then netrw or NERDTree
"Getting a better explorer,fern
Plug 'lambdalisue/vim-fern'

"vimlike surrounds and bracketing 
Plug 'tpope/vim-surround'

"File analysis/ error checking.Ale comes  built in with an lsp. 
"Plug 'dense-analysis/ale'
"Makes things excruciatingly slow. I can't take it. 

"better colorscheme, im tired boss. 
Plug 'danilo-augusto/vim-afterglow'

"wakatime integration because ofcourse
Plug 'wakatime/vim-wakatime'

" Plugins are now loaded after the call end]
call plug#end()

" TAGS 
function! UpdateTags()
	echom "Tags added"
	try
		let l:dir = expand('%:p:h') " l: => local variable. 
		let l:tagsfile = '' "expand => turns the string into the full path 
		let l:home = expand('~')

		while !empty(l:dir)
			let l:maybetag = l:dir . '/tags' 
			". is the string concat operator. 
			"adding /tags, then checking wether its a valid file that
			"exists. If yes, then that's the tag file. 
			if filereadable(l:maybetag)
				let l:tagsfile = l:maybetag
				break 
			endif 

			" ==# is the case sensitive equal operator. 
			" we're comparing dir to home, and to its parent. 
			" home is obv stop point, 
			" parent is as parent of root is root itself. /
			if l:dir ==# l:home || l:dir ==# fnamemodify(l:dir, ':h')
				break
			endif 
			
			"if we're here, tag file not found and we're not in home dir. 
			let l:dir = fnamemodify(l:dir, ':h')
			":h gets the parent dir, its teh head. 

		endwhile

		if empty(l:tagsfile)
			return
		endif "not a project then. 

		let l:file = expand('%:p')
		let l:cmd = 'ctags --append=yes --fields=+l --languages=' . &filetype . ' -o ' . shellescape(l:tagsfile) . ' ' . shellescape(l:file)
		"the above is complete chatgpt wizardry. 
		
		call system(l:cmd)
	catch /.*/
		echo "Error in UpdateTags:" . v:exception 
	endtry

endfunction


" Actual VIM setup 

set signcolumn=number
set encoding=utf-8
set updatetime=300

"vi breaks shit. this makes it not be like vi.
set nocompatible

"makes an un file that keeps history and allows for undos
set undofile

set path +=** "searches subfolder 

"allows for better search, basically highlighting all 
set incsearch
"ignores the case when searching
set ignorecase
"there's salso this other setting. does the same?
set smartcase
"clears the line when you refresh vim 
"viminfo =


" DEFINING VISUAL BEHAVIOR 

"all splits should be below, tbh dont fw upward openings. 
set splitbelow

"Highlight the symbol and its references when holding the cursor
au CursorHold * sil

"this will try to load the filetype, actually helps with recognition
filetype on
"turns on indenting
filetype indent on
"syntax highlighting yo
syntax on

"indenting is hard,
set smartindent 
set autoindent 
set copyindent
"smartindent technically does take care of things, but copyindent had to be
"used for ensuring proper nesting

"default tab lengths 
set tabstop=4 "manual tab for space conversion (if you use expandtab_)
set softtabstop=4 "visual representation (can be seperate from infile expantab)
set shiftwidth=4 "for autoindent to inherent tabs 
"do : retab for readjusting the tabs on a file 


"shows the word being matched 
set showmatch
"highlights the words being searched
set hlsearch
"shows the edit mode yo're in
set showmode
"shows the commands you're typing 
set showcmd

set wildmenu "this is just the tabcomplete that comes up

"clears the line when you refresh vim 
set statusline=
" Status line left side.
set statusline+=\ %F\ %y\ %r\ %m\ %h\ %{get(g:,'fart_text','')}
" Use a divider to separate the left side from the right side.
set statusline+=%=
" Status line right side.
set statusline+=\ row:\ %l\ col:\ %c\ len:\ %L\ :\ %p%% 
" Show the status on the second to last line.
set laststatus=2

"the cool numbering
set number relativenumber
"the cursor effects
set cursorline
set cursorcolumn 

colorscheme sorbet 

"by setting this, i can have vim take the terminal's bg as is, and hence;
"Translucent cool looking vim! Tada~
highlight Normal cterm=NONE ctermbg=NONE ctermfg=NONE

" CUSTOM STUFF

nnoremap <CR> :noh<CR>
"clear highlight when i do find the search term and press enter. 

"auto indent code keyremap 
nnoremap <leader>f <Cmd>normal! gg=G<CR>

" template for cp 
command! Newcp :0r ~/myElves/template.cpp 
" reads from the given file, then puts it at line 0 (i.e top of file)
" also, user defined commands must start from a capital letter. MYK.

"copy to system clipboard (i couldn't go throuhg the hassle of bulding vim to
"have the + register)
"command! Copy %w !clip.exe 
"Above is a windows terminal specific thing only.

"update the tags if we're in a project. 
autocmd BufWritePost * silent! call UpdateTags()

"autocorrections
inoreabbrev teh the 

