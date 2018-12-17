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

// THIS IS USED ACROSS SEVERAL FUNCTIONS TO FETCH THE LAST LIVE RATE PRICE
let lastPrice = parseFloat(document.getElementById('latest_price').value);

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
    buyWindowFiatAmount.value = 0
  } else {
    buyWindowFiatAmount.value = parseFloat(document.getElementById('latest_price').value) * parseFloat(buyWindowCryptoAmount.value)
  };
});


// THIS IS THE CODE IN THE BUY TO ON KEYUP DISPLAY THE AMOUNT OF CRYPTO THAT YOU WILL BUY AUTOMATICALLY
buyWindowFiatAmount.addEventListener('keyup', (event) => {
  let userBalance = parseFloat(document.getElementById('user_fiat_balance').value);
  let fiatAmount = parseFloat(document.getElementById('tradeValueFiatBuy').value);
  if (fiatAmount > userBalance ) {
    alert("NOT ENOUGH USD BALANCE");
    location.reload();
  } else if (isNaN(fiatAmount / lastPrice)) {
    buyWindowCryptoAmount.value = 0
  } else {
    buyWindowCryptoAmount.value = fiatAmount / lastPrice
  };
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
  if (cryptoAmount > cryptoBalance) {
    alert ("NOT ENOUGH CRYPTO BALANCE");
    location.reload();
  } else if (isNaN(lastPrice * cryptoAmount)) {
    sellWindowFiatAmount.value = 0
  } else {
    sellWindowFiatAmount.value = lastPrice * cryptoAmount
  };
});

// THIS IS THE CODE IN THE SELL TO ON KEYUP DISPLAY THE AMOUNT OF CRYPTO THAT YOU WILL SELL AUTOMATICALLY
sellWindowFiatAmount.addEventListener('keyup', (event) => {
  let fiatAmount = parseFloat(document.getElementById('tradeValueFiatSell').value);
  let cryptoBalance = parseFloat(document.querySelector('.user_crypto_balance').value)
  if ((fiatAmount / lastPrice) > cryptoBalance ) {
    alert("NOT ENOUGH CRYPTO BALANCE");
  } else if (isNaN(fiatAmount / lastPrice)) {
    sellWindowCryptoAmount.value = 0;
  } else {
    sellWindowCryptoAmount.value = fiatAmount / lastPrice
  };
});
