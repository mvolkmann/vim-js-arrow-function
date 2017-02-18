" This plugin defines a command that
" converts a JavaScript anonymous function to
" an arrow function (introduced in ES 2015).
"
" \_s matches newlines, spaces, and tabs
" \_. matches any character including newlines
" \_[^;] matches any character except semicolon, including newlines
" For more, see http://vimregex.com/ and
" http://vim.wikia.com/wiki/Search_across_multiple_lines.
"
" Backslashes in VimScript strings need to be escaped
" with an additional backslash.
"
" normal! - run following sequence of commands in normal mode;
"   ! means don’t use remapped commands
" $ - move to end of current line
" ?function\\s*(<cr> - search backward for the first anonymous function
" * can begin with "function (" or "function("
" dw - delete the "function" keyword
" f) - find the next right paren (end of parameter list)
" a => - append the arrow
" F) - find the preceding right paren (end of parameter list)
" va( - visually select the content of the containing parens (parameter list)
" \<esc> - exit visual selection mode
" :'<,'>s/(\\(\\w\\+\\))/\\1/e\<cr>" - remove parens around parameter list
"   with only one (a word, but no commas)
" The substitute "e" flag in the following two commands tells Vim
" that not finding a match should not be treated as an error.
" /{\<cr> - move to end of current line
" va{ - visually select the content of the containing braces
" \<esc> - exit visual selection mode
" :'<,'>s/{\\_s*return \\(\\_[^;]\\+\\);\\_s*}/\\1/e\<cr> -
"   if block begins with "return", remove braces and "return"

command! JsAnonFnToArrowFn execute "normal! $?function\\s*(\<cr>dwf)a =>\<esc>F)va(\<esc>:'<,'>s/(\\(\\w\\+\\))/\\1/e\<cr>/{\<cr>va{\<esc>:'<,'>s/{\\_s*return \\(\\_[^;]\\+\\);\\_s*}/\\1/e\<cr>"

function! Trim(string)
  return substitute(a:string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

function! JsArrowFnBraceToggle()
  let currLineNum = line('.')
  let currColNum = col('.')

  normal! 0 " move to beginning of line

  " Search for arrow starting at the current cursor position
  " and move the cursor to the end of the match if found (e option).
  let match = search('=>', 'e', currLineNum)

  " If arrow found ...
  if match
    " If the character two past the arrow is { ...
    let currLine = getline('.') " gets the entire current line
    let index = col('.') + 1 " index of character 2 past arrow
    let char = strpart(currLine, index, 2) " gets character two after match
    if char ==# '{'
      " Move cursor right two characters,
      " delete the open brace and the space that follows,
      " and move to the next word.
      "normal! llxxw
      normal! llxx

      let wordUnderCursor = expand('<cword>')
      if wordUnderCursor ==# '=>'
        " Move to next word
        normal! w
        let wordUnderCursor = expand('<cword>')
      endif

      if wordUnderCursor ==# 'return'
        normal! dw
      endif

      " Find the next } preceded by any amount of whitespace.
      call search('\s*}')

      " If the only thing on the line is }, delete the line
      let trimmedLine = Trim(getline('.'))
      if trimmedLine ==# '}' || trimmedLine ==# '};'
        normal! dd
      else
        normal! d$ " delete to end of line
      endif
    else
      " If nothing follows the arrow, join the next line.
      let wordUnderCursor = expand('<cword>')
      if wordUnderCursor ==# '=>'
        " Join next line to this one and move cursor left.
        normal! Jh
      endif

      " Add "{<cr>return" after arrow.
      execute "normal! a {\<cr>return "
      " Add } on next line.
      execute "normal! $a\<cr>};"
    endif
  else
    " Move cursor back to start.
    call cursor(currLineNum, currColNum)
    return 'not found'
  endif
endfunction

" If <leader>af is not already mapped ...
if mapcheck("\<leader>af", 'N') ==# ''
  nnoremap <leader>af :JsAnonFnToArrowFn<cr>
endif

" If <leader>tb is not already mapped ...
if mapcheck("\<leader>tb", 'N') ==# ''
  nnoremap <leader>tb :call JsArrowFnBraceToggle()<cr>
endif
