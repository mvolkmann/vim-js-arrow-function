# vim-js-arrow-function

This plugin provides two functions related to
JavaScript arrow functions.

The JsAnonFnToArrowFn function converts JavaScript anonymous functions
to arrow function expressions (introduced in ES 2015).

It converts this:
```javascript
function (p1, p2) {
  // some code
}
```
to this:
```javascript
(p1, p2) => {
  // some code
}
```
and converts this:
```javascript
function (n) { return n * 2; } 
```
to this:
```javascript
n => n * 2
```

Place the cursor anywhere inside the function, even on the `function` keyword,
and run the `JsAnonFnToArrowFn` command.

This command is mapped to &lt;leader&gt;af
(for "arrow function")
unless that is already mapped to something else.

The JsArrowFnBraceToggle function changes an arrow function from not using braces to using them and vice-versa.  The cursor must be on a line that contains "=>".

It converts this:
```javascript
const add = (p1, p2) => p1 + p2;
```
to this:
```javascript
const add = (p1, p2) => { return p1 + p2; };
```
and converts in the opposite direction.

This command is mapped to &lt;leader&gt;tb
(for "toggle braces")
unless that is already mapped to something else.

The easiest way to install this is to use Pathogen and
"git clone" this repository into the .vim/bundle directory.

## Differences between arrow functions and the `function` keyword

This plug-in will perform a simple transformation from a function declared with
the `function` keyword (a normal function) to an arrow function expression.
There are differences between these that can affect the results.

When an arrow function has an expression body, the `return` keyword is
implicit. However, when it has statement block, the `return` keyword is still
required just like a normal function.

```javascript
var example1 = function () { foo(); }; // example1() returns undefined

var example2 = () => { foo(); }; // example2() returns undefined

var example3 = () => foo(); // example3() returns the return value of foo()
```

Another difference is that normal functions always receive a `this` value,
whereas arrow functions inherit the `this` value from its context.

```javascript
$('a').each(function () { console.log(this); }; // logs all the "a" DOM elements

$('a').each(() => { console.log(this); }; // logs the window object
```

Resources:

- [Arrow functions blog post from hacks.mozilla.org](https://hacks.mozilla.org/2015/06/es6-in-depth-arrow-functions/)
