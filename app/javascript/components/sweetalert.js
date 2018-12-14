import swal from 'sweetalert';

function bindSweetAlertButtonDemo() {
  const swalButton = document.querySelectorAll('.sweet-alert-demo');

  swalButton.forEach((dom) => {
    let form = $(dom).closest('form')
    let url = form.attr('action')

    form.on('submit', (e) => {
      e.preventDefault()
      e.stopPropagation()

      swal({
        title: "Are you sure?",
        text: "Is this the cryptocurrency you wanna buy?",
        icon: "warning",
        buttons: true,
        dangerMode: true,
      }).then((willSave) => {
        if (willSave) {
          $.ajax({
            headers: {
              'X-CSRF-Token': $(form).find('[name="authenticity_token"]').val()
            },
            url: `${url}.json`,
            type: "POST"
          }).done(function() {
            swal("Booking canceled!", {
              icon: "success",
            }).then(() => {
              location.reload()
            });
          })
        }
      });
    })
  })
};

export { bindSweetAlertButtonDemo };
