(function () {
  let arr = [1, 2, 3];

  arr.forEach(function (number, index) {
    console.log('number', index, '=', number);
  });

  let dbl = arr.map(function(n) {
    return n + 2;
  });

  const answer = function (x) { return 42; };
})();
