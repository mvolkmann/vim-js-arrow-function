" This plugin defines a command that
" converts a JavaScript anonymous function to
" an arrow function (introduced in ES 2015).
"
" $ - move to end of current line
" ?function \\=(<cr> - search backward for the first anonymous function
" * can begin with "function (" or "function("
" dw - delete the "function" keyword
" f) - find the next right paren (end of parameter list)
" a => - append the arrow
" F) - find the preceding right paren (end of parameter list)
" va( - visually select the content of the containing parens (parameter list)
" \<esc> - exit visual selection mode
" :'<,'>s/(\\(\\w\\+\\))/\\1/e\<cr>" - remove parens around parameter list with only one
" The substitute "e" flag in the following two commands tells Vim
" that not finding a match should not be treated as an error.
" $ - move to end of current line
" va{ - visually select the content of the containing braces
" \<esc> - exit visual selection mode
" :'<,'>s/{\\_s*return \\(\\_[^;]\\+\\);\\_s*}/\\1/e\<cr> -
"   if block begins with "return", remove braces and "return"
"
" \_s matches newlines, spaces, and tabs
" \_. matches any character including newlines
" \_[^;] matches any character except semicolon, including newlines
" For more, see http://vimregex.com/ and
" http://vim.wikia.com/wiki/Search_across_multiple_lines.
"
" Backslashes in VimScript strings need to be escaped
" with an additional backslash.

command! JsAnonFnToArrowFn execute "normal! $?function \\=(\<cr>dwf)a =>\<esc>F)va(\<esc>:'<,'>s/(\\(\\w\\+\\))/\\1/e\<cr>$va{\<esc>:'<,'>s/{\\_s*return \\(\\_[^;]\\+\\);\\_s*}/\\1/e\<cr>"

nnoremap <leader>af :JsAnonFnToArrowFn<cr>
