/*eslint-disable no-unused-vars */

// Works - maybe shouldn't since > 1 statement in braces
const foo = (p1, p2) => {
  const bar = 1;
  return bar * 2;
};

// Works!
const bar = (p1, p2) => {
  return 'some text';
};

// Works!
const qux = (p1, p2) =>
  'some text';

if (true) {
  const baz = (p1, p2) => {
    return 'some text';
  };
}
