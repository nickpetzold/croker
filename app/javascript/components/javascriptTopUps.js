const javascriptTopUps = () => {
  let topUpAmount = document.getElementById('top_up_fiat_amount');
  topUpAmount && topUpAmount.addEventListener('click', (event) => {
      topUpAmount.value = ""
  });
}

export { javascriptTopUps }
