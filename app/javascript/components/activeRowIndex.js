const indexRows = document.querySelector('index-row');

if (indexRows) {
  indexRows.forEach((row) => {
    row.addEventListener('click', function() {
      indexRows.forEach((row) => {
        row.classList.remove('active');
      })
      row.classList.add('active');
    });
  });
}

export { sortTable };
