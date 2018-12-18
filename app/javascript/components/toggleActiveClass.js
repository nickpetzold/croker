const toggleActiveClass = (() => {

  const rows = document.querySelectorAll('.index-row');

  if (rows) {
    rows.forEach((row) => {
      row.addEventListener('click',function() {
        rows.forEach((row) => {
          row.classList.remove('active-row');
        })
        row.classList.add('active-row');
      });
    });
  };
});

export { toggleActiveClass };
