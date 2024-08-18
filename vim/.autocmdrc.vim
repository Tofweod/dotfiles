autocmd BufNewFile,BufRead *.h set filetype=c 
autocmd FileType c,h setlocal tabstop=8 shiftwidth=8
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
