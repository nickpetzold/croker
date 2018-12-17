const removeFlashes = function() {
  $(document).ready(function(){
      setTimeout(function() {
        if (document.querySelector('.alert-dismissible')) {
          document.querySelector('.alert-dismissible').remove();
        }
  }, 2000);
  });
};

export{ removeFlashes };
