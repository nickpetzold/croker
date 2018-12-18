const buyAndSellAnimations = (() => {

  // THIS IS THE CONST TO GET THE BUY TAB
  const buyTab = document.getElementById('buy-trade');
  // THIS IS THE CONST TO GET THE SELL TAB
  const sellTab = document.getElementById('sell-trade');


  // WITHIN THE BUY FORM THIS IS THE AMOUNT OF CRYPTO THE USER WILL TYPE IN/BUY
  const buyWindowCryptoAmount = document.getElementById('tradeValueCryptoBuy');
  // WITHIN THE BUY FORM THIS IS THE AMOUNT OF FIAT THE USER WILL TYPE IN/PAY
  const buyWindowFiatAmount = document.getElementById('tradeValueFiatBuy');
  // WITHIN THE SELL FORM THIS IS THE AMOUNT OF CRYPTO THE USER WILL TYPE IN/SELL
  const sellWindowCryptoAmount = document.getElementById('tradeValueCryptoSell');
  // WITHIN THE SELL FORM THIS IS THE AMOUNT OF FIAT THE USER WILL TYPE IN/RECEIVE
  const sellWindowFiatAmount = document.getElementById('tradeValueFiatSell');
  // MAX BUTTONS DEFINED BELOW
  const buyCyptoMaxBtn = document.getElementById('buy-crypto-max');
  const buyFiatMaxBtn = document.getElementById('buy-fiat-max');

  // TRADE BUTTONS DEFINED BELOW
  const buyTradeBtn = document.querySelector('.buy-trade-btn');

  // THIS IS USED ACROSS SEVERAL FUNCTIONS TO FETCH THE LAST LIVE RATE PRICE
  let lastPrice = parseFloat(document.getElementById('latest_price').value);

  // THIS IS THE USER BALANCE AT THE TIME OF PAGE LOADING
  let userBalance = parseFloat(document.getElementById('user_fiat_balance').value);
  // THIS SETS THE FIAT LABEL BACK TO USD ONCE THE PAGE LOADS
  buyWindowFiatAmount.value = 'USD';
  // BE VERY CAREFUL WHILE INTERPRETING THIS PART OF CODE
  // SO HOW THIS IS WORKS IS LIKE THIS. WE HAVE THE BUY TAB AND SELL
  // SINCE WE ARE RENDING TWO FORMS, ONE BUY AND ONE SELL, THE SELL IS HIDDEN BY DEFAULT BTW
  // WE NEED TO CREATE 2 EVENT LISTENERS CLICK FOR THE BUY TAB AND ONE FOR THE SELL TAB
  // EVERYTIME WE CLICK ON BUY OR SELL TAB A NEW FORM IS DISPLAYED ACCORDINGLY
  // WE MANIPULATE THIS INFORMATION WITH THE HIDDEN FIELD SO *DO NOT* REMOVE IT FROM HTML

  // ------------------ THIS IS WHERE THE BUY PART STARTS ---------------------
  // THIS IS THE CODE TO SHOW THE BUY FORM AFTER CLICKING THE BUY TAB AND HIDE THE SELL FORM
  buyTab.addEventListener('click', (event) => {
    document.getElementById("tradeValueCryptoBuy").value = ''
    document.getElementById("tradeValueFiatBuy").value = ''
    document.querySelector('.buy-sell-tabs').firstElementChild.classList.add("tab-selected")
    document.querySelector('.buy-sell-tabs').lastElementChild.classList.remove("tab-selected")
    document.querySelector(".buy-input-container, sell-window").classList.add("hidden")
    document.querySelector(".buy-window").classList.remove("hidden")
    document.querySelector('.balance').innerText = document.getElementById('user_fiat_balance').value
  });

  // THIS IS THE CODE IN THE BUY TO ON KEYUP DISPLAY THE AMOUNT TO PAY AUTOMATICALLY
  buyWindowCryptoAmount.addEventListener('keyup', (event) => {
    if (isNaN(parseFloat(document.getElementById('latest_price').value) * parseFloat(buyWindowCryptoAmount.value))) {
      buyWindowFiatAmount.value = 'USD';
    } else {
      buyWindowFiatAmount.value = (parseFloat(document.getElementById('latest_price').value) * parseFloat(buyWindowCryptoAmount.value)).toFixed(2);
      if (buyWindowFiatAmount.value > userBalance) {
        document.querySelector('.crypto-trade-warning-message').innerText = 'You have insufficient funds.';
      } else {
        document.querySelector('.crypto-trade-warning-message').innerText = '';
      }
    };
  });

  buyWindowCryptoAmount.addEventListener('click', (event) => {
    buyWindowCryptoAmount.value = '';
  });

  buyCyptoMaxBtn.addEventListener('click', (event) => {
    buyWindowCryptoAmount.value = userBalance / lastPrice;
    buyWindowFiatAmount.value = userBalance;
  });

  // THIS IS THE CODE IN THE BUY TO ON KEYUP DISPLAY THE AMOUNT OF CRYPTO THAT YOU WILL BUY AUTOMATICALLY
  buyWindowFiatAmount.addEventListener('keyup', (event) => {
    let fiatAmount = parseFloat(document.getElementById('tradeValueFiatBuy').value);
    if (isNaN(fiatAmount / lastPrice)) {
        buyWindowCryptoAmount.value = 'BTC'
      } else {
        const cryptoAmount = fiatAmount / lastPrice;
        if (cryptoAmount < 10) {
          buyWindowCryptoAmount.value = cryptoAmount.toFixed(4)
        } else {
          buyWindowCryptoAmount.value = cryptoAmount.toFixed(2)
        }

      if (buyWindowFiatAmount.value > userBalance) {
          document.querySelector('.fiat-trade-warning-message').innerText = 'You have insufficient funds.';
          buyTradeBtn.disabled = true;
        } else {
          document.querySelector('.fiat-trade-warning-message').innerText = '';
          buyTradeBtn.disabled = false;
        }
      };
  });

  buyWindowFiatAmount.addEventListener('click', (event) => {
    buyWindowFiatAmount.value = '';
  });

  buyFiatMaxBtn.addEventListener('click', (event) => {
    buyWindowFiatAmount.value = userBalance;
    buyWindowCryptoAmount.value = userBalance / lastPrice;
  });

  // ------------------ THIS IS WHERE THE SELL PART STARTS ---------------------
  // THIS IS THE CODE TO SHOW THE SELL FORM AFTER CLICKING THE SELL TAB AND HIDE THE BUY FORM

  sellTab.addEventListener('click', (event) => {
    document.getElementById("tradeValueCryptoSell").value = ''
    document.getElementById("tradeValueFiatSell").value = ''
    document.querySelector('.buy-sell-tabs').firstElementChild.classList.remove("tab-selected")
    document.querySelector('.buy-sell-tabs').lastElementChild.classList.add("tab-selected")
    document.querySelector(".buy-window").classList.add("hidden")
    document.querySelector(".buy-input-container, sell-window, hidden").classList.remove("hidden")
    document.querySelector('.balance').innerText = document.querySelector('.user_crypto_balance').value
  })

  // THIS IS THE CODE IN THE SELL TO ON KEYUP DISPLAY THE AMOUNT YOU WILL RECEIVE AUTOMATICALLY

  sellWindowCryptoAmount.addEventListener('keyup', (event) => {
    let cryptoBalance = parseFloat(document.querySelector('.user_crypto_balance').value)
    let cryptoAmount = parseFloat(sellWindowCryptoAmount.value)
    let cryptoName = document.getElementById('tradeValueCryptoSell').placeholder.split(' ')[1]
    if (cryptoAmount > cryptoBalance) {
      swal("Oops.. something went wrong...")
        .then((value) => {
          swal(`Seems like you have ${cryptoBalance} - ${cryptoName}`);
      });
      // location.reload();
    } else if (isNaN(lastPrice * cryptoAmount)) {
      sellWindowFiatAmount.value = 0
    } else {
      sellWindowFiatAmount.value = lastPrice * cryptoAmount
    };
  });

  // THIS IS THE CODE IN THE SELL TO ON KEYUP DISPLAY THE AMOUNT OF CRYPTO THAT YOU WILL SELL AUTOMATICALLY
  sellWindowFiatAmount.addEventListener('keyup', (event) => {
    let fiatAmount = parseFloat(document.getElementById('tradeValueFiatSell').value);
    let cryptoBalance = parseFloat(document.querySelector('.user_crypto_balance').value);
    let cryptoName = document.getElementById('tradeValueCryptoSell').placeholder.split(' ')[1]
    if ((fiatAmount / lastPrice) > cryptoBalance ) {
      swal("Oops.. something went wrong...")
        .then((value) => {
          swal(`Seems like you have ${cryptoBalance} ${cryptoName}`);
      });
    } else if (isNaN(fiatAmount / lastPrice)) {
      sellWindowCryptoAmount.value = 0;
    } else {
      sellWindowCryptoAmount.value = fiatAmount / lastPrice
    };
  });

});

export { buyAndSellAnimations };
