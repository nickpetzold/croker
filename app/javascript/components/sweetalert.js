import swal from 'sweetalert';

// SWEET ALERT FROM WHEELS PROJECT
// POST NOT WORKING

// function bindSweetAlertButtonDemo() {
//   const swalButton = document.querySelectorAll('.sweet-alert-demo');

//   swalButton.forEach((dom) => {
//     let form = $(dom).closest('form')
//     let url = '/trades'

//     form.on('submit', (e) => {
//       e.preventDefault()
//       e.stopPropagation()

//       swal({
//         title: "Are you sure?",
//         text: "Is this the cryptocurrency you wanna buy?",
//         icon: "warning",
//         buttons: true,
//         dangerMode: true,
//       }).then((willSave) => {
//         if (willSave) {
//           $.ajax({
//             headers: {
//               'X-CSRF-Token': $(form).find('[name="authenticity_token"]').val()
//             },
//             url: `${url}.json`,
//             type: "POST"
//           }).done(function() {
//             swal("Booking canceled!", {
//               icon: "success",
//             }).then(() => {
//               location.reload()
//             });
//           })
//         }
//       });
//     })
//   })
// };


function bindSweetAlertButtonDemo() {
  const submitBtn = document.querySelector('.sweet-alert-demo');
  const form = document.getElementById('new_trade');
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
      form.submit();

    }
  });
});
};

  export { bindSweetAlertButtonDemo };
