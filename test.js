/*eslint-disable brace-style, no-unused-vars, prefer-arrow-callback */

const arr = [1, 2, 3];

arr.forEach(function () {
  console.log('got an element');
});

arr.forEach(function (number, index) {
  console.log('number', index, '=', number);
});

const dbl = arr.map(function (n) {
  return n + 2;
});

const answer = function (x) { return 42; };

const add = (p1, p2) =>
  p1 + p2;

const sum = (p1, p2) => p1 + p2;

const foo = (p1, p2) => {
  const bar = 1;
  return bar * 2;
};

const bar = (p1, p2) => {
  return 'some text';
};

const qux = (p1, p2) =>
  'some text';

if (true) {
  const baz = (p1, p2) => {
    return 'some text';
  };
}
