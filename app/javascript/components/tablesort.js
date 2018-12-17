import Tablesort from 'tablesort';
// import TableNumbers from 'tablesort/src/sorts/tablesort.number.js'
// import 'tablesort.min.js' from 'tablesort';
// import 'tablesort.number.js' from 'tablesort';

function extendNumbers(Tablesort){
  var cleanNumber = function(i) {
    return i.replace(/[^\-?0-9.]/g, '');
  },

  compareNumber = function(a, b) {
    a = parseFloat(a);
    b = parseFloat(b);

    a = isNaN(a) ? 0 : a;
    b = isNaN(b) ? 0 : b;

    return a - b;
  };

  Tablesort.extend('number', function(item) {
    return item.match(/^[-+]?[£\x24Û¢´€]?\d+\s*([,\.]\d{0,2})/) || // Prefixed currency
      item.match(/^[-+]?\d+\s*([,\.]\d{0,2})?[£\x24Û¢´€]/) || // Suffixed currency
      item.match(/^[-+]?(\d)*-?([,\.]){0,1}-?(\d)+([E,e][\-+][\d]+)?%?$/); // Number
  }, function(a, b) {
    a = cleanNumber(a);
    b = cleanNumber(b);

    return compareNumber(b, a);
  });
};

const table = document.getElementById('portfolio-overview-table');
table.addEventListener('afterSort', function() {
    const ranks = document.querySelectorAll('.body-rank');
    ranks.forEach((element, index) => {
      element.innerText = index + 1;
    })
  });
// console.log(TableNumbers)

console.log(Tablesort)
extendNumbers(Tablesort);

const sortTable = new Tablesort(table, {
  descending: true
});


export { sortTable };
