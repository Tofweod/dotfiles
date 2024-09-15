call plug#begin()
 
    Plug 'neoclide/coc.nvim',{'branch':'release'} 
 
    Plug 'jiangmiao/auto-pairs'
    Plug 'majutsushi/tagbar'
    Plug 'lokaltog/vim-easymotion'
    " Plug 'fholgado/minibufexpl.vim'
	Plug 'gcmt/taboo.vim'
	Plug 'zefei/vim-wintabs'
	Plug 'zefei/vim-wintabs-powerline'
	Plug 'itchyny/lightline.vim'
	Plug 'mhinz/vim-signify', {'tag':'legacy'}
    Plug 'yggdroot/leaderf', {'do':':leaderfinstallcextension'}
 
    Plug 'tpope/vim-surround'
    Plug 'preservim/nerdcommenter'
    " plin 'thaerkh/vim-workspace'
    Plug 'tpope/vim-obsession'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'mhinz/vim-startify'
    Plug 'sakshamgupta05/vim-todo-highlight'
	" Plug 'Shougo/deoplete.nvim'
	Plug 'Shougo/echodoc.vim'
	Plug 'rhysd/clever-f.vim'

	Plug 'mg979/vim-visual-multi'

	Plug 'freitass/todo.txt-vim'

	Plug 'drmikehenry/vim-fixkey'
	
	Plug 'preservim/nerdtree'

	Plug 'catppuccin/vim', { 'as': 'catppuccin' }
call plug#end()
filetype plugin indent on
colorscheme catppuccin_frappe

" coc.nvim
set updatetime=100

set signcolumn=yes


inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
 
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
 
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
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> <c-[> <Plug>(coc-diagnostic-prev)
nmap <silent> <c-]> <Plug>(coc-diagnostic-next)
" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
 
" Use K to show documentation in preview window
nnoremap <silent> gh :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
 
" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format)
 
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
 
" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nnoremap <leader>xx :CocList diagnostics<CR>
nmap <leader>xc  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>xs  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>xf  <Plug>(coc-fix-current)
" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
 
" Run the Code Lens action on the current line
" nmap <leader>cl  <Plug>(coc-codelens-action)
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
 
" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
 
" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')
" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
 
" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Mappings for CoCList
nnoremap <silent><nowait> <space>cl  :<C-u>CocList<cr>
" Show all diagnostics
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
nnoremap <silent><nowait> <space>sy  :<C-u>CocList -I symbols<cr>
" " Do default action for next item
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" 

" tagbar
nmap <leader>a :TagbarToggle<CR>
let g:tagbar_autofocus=1
let g:tagbar_type_ruby = {
			\ 'kinds': [
				\ 'm:modules',
				\ 'c:classes',
				\ 'd:describes',
				\ 'C:contexts',
				\ 'f:methods',
				\ 'F:singleton methods'
			\]
\}

" easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase=1

nmap s <Plug>(easymotion-overwin-f2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


" wintabls
nnoremap <s-l> <plug>(wintabs_next)<CR>
nnoremap <s-h> <plug>(wintabs_previous)<CR>
nnoremap <leader>bd <plug>(wintabs_close)<CR>
nnoremap <leader>wd <plug>(wintabs_close_window)<CR>
nnoremap <M-1> :WintabsGo 1<CR>
nnoremap <M-2> :WintabsGo 2<CR>
nnoremap <M-3> :WintabsGo 3<CR>
nnoremap <M-4> :WintabsGo 4<CR>
nnoremap <M-5> :WintabsGo 5<CR>
nnoremap <M-6> :WintabsGo 6<CR>
nnoremap <M-7> :WintabsGo 7<CR>
nnoremap <M-8> :WintabsGo 8<CR>
nnoremap <M-9> :WintabsGo 9<CR>

let g:wintabs_powerline_arrow_right = "\u25b6"
let g:wintabs_powerline_sep_buffer_transition="\ue0b0"
let g:wintabs_powerline_sep_buffer="\ue0b1"



" taboo.vim
set guioptions-=e
set sessionoptions+=tabpages,globals


" Leaderf
let g:Lf_WindowPosition='popup'
let g:Lf_RootMarkers = ['.git', 'build']
let g:Lf_WildIgnore = {
			\ 'dir':['.git','build']
			\}

noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>ff :<C-U><C-R>=printf("Leaderf file %s", "")<CR><CR>
noremap <leader>fg :Leaderf rg --live -g '!build/'<CR>
noremap <leader>fs :CocList -I symbols<CR>

"noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
"noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
" xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>


" NERDCommenter
let g:NERDCreateDefaultMappings=0
let g:NERDSpaceDelims=1
let g:NERDCompactSexyComs=1
let g:NERDCommentEmptyLines=1
let g:NERDToggleCheckAllLines=1

map gcc <plug>NERDCommenterToggle
map gcb <plug>NERDCommenterSexy

" startify
let g:startify_session_persistence=1
let g:startify_session_delete_buffers=1
let g:startify_custom_indices = map(range(1,100), 'string(v:val)')
let g:startify_bookmarks=[
			\ {'c': '~/.vimrc'},
			\ {'zc': '~/.zshrc'},
			\ {'td':'~/.todo/todo.txt'}
			\]
nnoremap <leader>ss :SSave<CR>
nnoremap <leader>sl :SLoad<CR>
nnoremap <leader>sd :SDelete<CR>
nnoremap <leader>sc :SClose<CR>


" echodoc
let g:echodoc#enable_at_startup=1
let g:echodoc#type='popup'
" highlight link EchoDocPopup Pmenu

" lightline
let g:lightline = {
			\ 'colorscheme': 'catppuccin_mocha',
			\ 'subseparator': {'left':'>'},
			\ 'active': {
			\ 'left': [ [ 'mode','paste' ],
			\           [ 'cocstatus'],
			\           ['filename', 'coc_symbol_line'],
			\           ['modified' ]]
			\},
			\ 'component_function': {
			\  'cocstatus': 'coc#status',
			\  'coc_symbol_line':'CocSymbolLine'
			\},
			\}

function ColorCocSymbolLine()
	return get(b:,'coc_symbol_line_plain','')
endfunction

function CocSymbolLine()
	return substitute(ColorCocSymbolLine(),'%#CocSymbolLine#','','g')
endfunction

" set statusline=%!ColorCocSymbolLine()

" vim-visual-multi
let g:VM_highlight_matches          = 'underline'

" nerdtree
nnoremap <leader>e :NERDTreeToggle<CR>
