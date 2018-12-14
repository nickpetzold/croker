const removeFlashes = function() {
  $(document).ready(function(){
      setTimeout(function() {
      document.querySelector('.alert-dismissible').remove();
  }, 2000);
  });
};

export{ removeFlashes };
