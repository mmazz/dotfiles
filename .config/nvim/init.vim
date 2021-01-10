let mapleader = ","
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto install vim-plug
" system hace ejecutar el comando
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
	" macros para cambiar algo dentro de comillas y las cambia por otras
	Plug 'tpope/vim-surround'
	Plug 'preservim/nerdtree'
	" para centrar el texto y quede mejor, ajusta automaticamente cosas
	Plug 'junegunn/goyo.vim'
	" manejar git dentro de vim, todavia no lo uso...
	Plug 'jreybert/vimagit'
	" una wiki propia
	Plug 'vimwiki/vimwiki'
	" la barra de abajo que da info
	Plug 'bling/vim-airline'
	"comentar lineas
	Plug 'tpope/vim-commentary'
	"Plug 'ap/vim-css-color'
	Plug 'arcticicestudio/nord-vim'
call plug#end()

" Better Syntax Support Plug 'sheerun/vim-polyglot'
" Intelligance " Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Auto pairs for '(' '[' '{'  Plug 'jiangmiao/auto-pairs'
" Latex    Plug 'lervag/vimtex'
" Plug 'ycm-core/YouCompleteMe'
" FZF, for searchibg   Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" Plug 'airblade/vim-rooter'
" View of classes and methods    Plug 'majutsushi/tagbar'
"Plug 'ying17zi/vim-live-latex-preview'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" ver si lo dejo, es para buscar
map <C-F> /
" Set the window’s title, reflecting the file currently being edited
set title
set bg=light " ?
set go=a " ?
" permite uso de mouse
set mouse=a
"is used not to highlight every occurrence of searched word. When we use this command we can shift the cursor to the next occurrence using n command.
set nohlsearch
" permite copiar con Ctrl+c en otro programa y pegarlo a vim con p
set clipboard+=unnamedplus
"remove the vim mode information line, as it’s displayed in status line (vim-airline).
set noshowmode

" saca la info de la barra de las cordenadas de donde esta el cursor
set noruler
" desabilita la statusbar, si pongo 2 queda siempre xxx probar
set laststatus=0
"turn off the display of commands which we enter in the file.
set noshowcmd

" Some basics:
	"cuando copiamos algo y borramos una linea donde vamos a poner se copia eso y pierdo lo otro. Asi uso el blackhole
	nnoremap c "_c
	" nocompatible permite funciones que VI no soporta ?
	set nocompatible
	set tabstop=4
	set shiftwidth=4
	set expandtab
	filetype plugin on
	"activaremos para el fichero actual el coloreado de sintaxis"
	syntax on
	colorscheme nord
	set encoding=utf-8
	" si pongo number pone los numeros absolutos
	set number relativenumber

" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Perform dot commands over visual blocks: "allow the . to execute once for each line of a visual selection
	vnoremap . :normal .<CR>
" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set bg=light \| set linebreak<CR>
" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    if has('nvim')
        let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
    else
        let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
    endif

" vimling:
	nm <leader><leader>d :call ToggleDeadKeys()<CR>
	imap <leader><leader>d <esc>:call ToggleDeadKeys()<CR>a
	nm <leader><leader>i :call ToggleIPA()<CR>
	imap <leader><leader>i <esc>:call ToggleIPA()<CR>a
	nm <leader><leader>q :call ToggleProse()<CR>

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Replace ex mode with gq
	map Q gq

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck -x %<CR>


" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc."  \| es lo que antes era solo |
	map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable Goyo by default for mutt writing
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost bm-files,bm-dirs !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufRead,BufNewFile xresources,xdefaults set filetype=xdefaults
	autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
" Recompile dwmblocks on config edit.
	autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

" Function for toggling the bottom statusbar:
let s:hidden_all = 1
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>
" Quiero hacer que si agrego ñ automaticamente me haga \~n.
	autocmd FileType tex inoremap ñ \~n
	autocmd FileType tex inoremap á \'a
	autocmd FileType tex inoremap é \'e
	autocmd FileType tex inoremap í \'i
	autocmd FileType tex inoremap ó \'o
	autocmd FileType tex inoremap ú \'u
""" Latex
	autocmd FileType tex inoremap ,bf \textbf{}<Esc>T{i
	autocmd FileType tex inoremap ,ti \textit{}<Esc>T{i
	autocmd FileType tex inoremap ,em \emph{}<Esc>T{i
	autocmd FileType tex inoremap ,it \begin{itemize}<Enter><Enter>\end{itemize}<Esc>1kA\item<Space>
	autocmd FileType tex inoremap ,en \begin{enumerate}<Enter><Enter>\end{enumerate}<Esc>1kA\item<Space>
	autocmd FileType tex inoremap ,eq \begin{equation}<Enter><Enter>\end{equation}<Esc>1kA<Tab>
	autocmd FileType tex inoremap ,fi \begin{figure}[H]<Enter><Enter>\end{figure}<Esc>1kA<Tab>\centering<Enter>\includegrahics{width=\linewidth}{}<Enter>\caption{}<Enter>\label{}<Esc>2k$i




