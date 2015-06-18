# vim-js-arrow-function

This plugin converts JavaScript anonymous functions
to arrow function expressions (introduced in ES 2015).

Place the cursor anywhere inside the function,
even on the "function" keyword,
and run the JsAnonFnToArrowFn command.

This command is mapped to <leader>af
unless that is already mapped to something else..

The easiest way to install this is to use Pathogen and
"git clone" this repository into the .vim/bundle directory.

## Differences between arrow functions and the `function` keyword

This plug-in will perform a simple transformation from a function declared with
the `function` keyword to an arrow function expression. It is good to bear in
mind the differences between these two expressions, so as to spot when the
result is not exactly equivalent.

When an arrow function has an expression body, the `return` keyword is
implicit. However, when it has statement block, the `return` keyword is still
required just like a normal function.

```javascript
var example = function () { foobar(); }; // example() always returns null

var example2 = () => { foobar(); }; // example2() always returns null

var example3 = () => foobar(); // example3() will return the return value of foobar()

```

The other difference is that normal functions always receive a `this` value,
whereas arrow functions inherit the `this` value from its context.

```javascript
$("a").each(function() { console.log(this); }; // logs "a" DOM elements

$("a").each(() => { console.log(this); }; // logs the window object
```

Resources:

- [Arrow functions blog post from hacks.mozilla.org](https://hacks.mozilla.org/2015/06/es6-in-depth-arrow-functions/)
