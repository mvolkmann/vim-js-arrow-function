" $ - move to end of current line
" ?function \\=(<cr> - search backward for the first anonymous function
" * can begin with "function (" or "function("
" dw - delete the "function" keyword
" f) - find the next right paren (end of parameter list)
" a => - append the arrow
" F) - find the preceding right paren (end of parameter list)
" va( - visually select the content of the containing parens (parameter list)
" \<esc> - exit visual selection mode
" :s/(\\(\\w\\+\\))/\\1/e\<cr>" - remove parens around parameter list with only one
" The substitute "e" flag in the following two commands tells Vim
" that not finding a match should not be treated as an error.
command! JsAnonFnToArrowFn execute "normal! $?function \\=(\<cr>dwf)a =>\<esc>F)va(\<esc>:'<,'>s/(\\(\\w\\+\\))/\\1/e\<cr>"
nnoremap <leader>af :JsAnonFnToArrowFn<cr>
