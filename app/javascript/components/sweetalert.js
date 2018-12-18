import swal from 'sweetalert';

function bindSweetAlertButtonDemo() {
  const submitBtn = document.querySelector('.sweet-alert-demo');
  const form = document.getElementById('new_trade');
  if (submitBtn) {
    submitBtn.addEventListener('click', function(event) {
      event.preventDefault();

    swal({
      title: "Are you sure?",
      text: "You will not be able to recover this imaginary file!",
      icon: "warning",
      buttons: [
      'No, cancel it!',
      'Yes, I am sure!'
      ],
      dangerMode: true,
    }).then(function(isConfirm) {
      if (isConfirm) {
        swal('Hello from Test!', {
          icon: "success",
        }).then (()=> {
          form.submit();
        });
        }
      });
    });
  };
};

  export { bindSweetAlertButtonDemo };
