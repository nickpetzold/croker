const removeFlashes = function() {
  $(document).ready(function(){
      setTimeout(function() {
      document.querySelector('.alert-dismissible').remove();
  }, 3000);
  });
};

export{ removeFlashes };
