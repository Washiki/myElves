"  NICE COLORSCHEMES
"    retrobox 
"    seoul256 //external 
"     slate
"     sorbet 
"     habamax


"this calls the plugins
call plug#begin('~/.vim/plugged')

"for the bad times. 
Plug 'github/copilot.vim'

"intellisense implement, it seems to be fine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"emmet
Plug 'mattn/emmet-vim'

"a faster commenter
Plug 'preservim/nerdcommenter'

"color highlighting
Plug 'ap/vim-css-color'

"noncompatible on steroids 
Plug 'tpope/vim-sensible'

"random theme i like 
Plug 'junegunn/seoul256.vim'

"LATEX IN VIM JUST LIKE THAT ONE MATH TUT
Plug 'lervag/vimtex'

"sidebar file explorer 
Plug 'preservim/nerdtree'

"vimlike surrounds and bracketing 
Plug 'tpope/vim-surround'

"File analysis/ error checking. the W E stuff 
"Plug 'dense-analysis/ale'
"Makes things excruciatingly slow. I can't take it. 

" Plugins are now loaded after the call end]
call plug#end()

"remapping the leader. IMportant. 
let g:mapleader = ","
"auto indent code keyremap 

nnoremap <leader>f <Cmd>normal! gg=G<CR>

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
set statusline+=\ %F\ %y\ %r\ %m\ %h
" Use a divider to separate the left side from the right side.
set statusline+=%=
" Status line right side.
set statusline+=\ row:\ %l\ col:\ %c\ total:\ %L\ percent:\ %p%% 
" Show the status on the second to last line.
set laststatus=2

"the cool numbering
set number relativenumber
"the cursor effects
set cursorline
"set cursorcolumn 

colorscheme seoul256


" CUSTOM STUFF


nnoremap <CR> :noh<CR>
"clear highlight when i do find the search term and press enter. 

" template for cp 
command! Newcp :0r ~/myElves/template.cpp 
" reads from the given file, then puts it at line 0 (i.e top of file)
" also, user defined commands must start from a capital letter. MYK.

"copy to system clipboard (i couldn't go throuhg the hassle of bulding vim to
"have the + register)
command! Copy :%w !clip.exe 

"update the tags if we're in a project. 
autocmd BufWritePost * silent! call UpdateTags()

"autocorrections
inoreabbrev teh the 

" STARTUP BEHAVIOR

"open nerdtree by default, typing it is way too hard man
"au VimEnter *  NERDTree
"
"put me directly in the main editor 
"autocmd VimEnter * execute "normal! \<C-w>w"

"disable copilot by default. I hate it. 
au VimEnter * Copilot disable

"for cpp cp, take shit from the template. 
"au VimEnter * Newcp

"sets colorscheme 
"colorscheme seoul256


