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
  const sellCyptoMaxBtn = document.getElementById('sell-crypto-max');
  const sellFiatMaxBtn = document.getElementById('sell-fiat-max');
  // TRADE BUTTONS DEFINED BELOW
  const buyTradeBtn = document.getElementById('buy-trade-btn');
  const sellTradeBtn = document.getElementById('sell-trade-btn');

  // THIS IS USED ACROSS SEVERAL FUNCTIONS TO FETCH THE LAST LIVE RATE PRICE
  let lastPrice = parseFloat(document.getElementById('latest_price').value);

  // THIS IS THE USER BALANCE AT THE TIME OF PAGE LOADING
  let userBalance = parseFloat(document.getElementById('user_fiat_balance').value);
  // THIS IS THE USER CRYPTO BALANCE AT THE TIME OF PAGE LOADING
  let cryptoBalance = parseFloat(document.getElementById('crypto_amount_held').value);
  // THIS SETS THE FIAT LABEL BACK TO USD ONCE THE PAGE LOADS
  buyWindowFiatAmount.value = 'USD';
  buyTradeBtn.disabled = true;
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
    document.getElementById('balance').innerText = `$${userBalance.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2})}`;
    buyTradeBtn.disabled = true;
  });

  // THIS IS THE CODE IN THE BUY TO ON KEYUP DISPLAY THE AMOUNT TO PAY AUTOMATICALLY
  buyWindowCryptoAmount.addEventListener('keyup', (event) => {
    if (isNaN(parseFloat(document.getElementById('latest_price').value) * parseFloat(buyWindowCryptoAmount.value))) {
      buyWindowFiatAmount.value = 'USD';
      buyTradeBtn.disabled = true;
    } else {
      buyWindowFiatAmount.value = (parseFloat(document.getElementById('latest_price').value) * parseFloat(buyWindowCryptoAmount.value)).toFixed(2);
      if (buyWindowFiatAmount.value > userBalance) {
        document.querySelector('.buy-crypto-trade-warning-message').innerText = 'You have insufficient funds.';
        buyTradeBtn.disabled = true;
      } else {
        document.querySelector('.buy-crypto-trade-warning-message').innerText = '';
        buyTradeBtn.disabled = false;
      }
    };
  });

  buyWindowCryptoAmount.addEventListener('click', (event) => {
    buyWindowCryptoAmount.value = '';
  });

  buyCyptoMaxBtn.addEventListener('click', (event) => {
    buyWindowCryptoAmount.value = userBalance / lastPrice;
    buyWindowFiatAmount.value = userBalance;
    buyTradeBtn.disabled = false;
  });

  // THIS IS THE CODE IN THE BUY TO ON KEYUP DISPLAY THE AMOUNT OF CRYPTO THAT YOU WILL BUY AUTOMATICALLY
  buyWindowFiatAmount.addEventListener('keyup', (event) => {
    let fiatAmount = parseFloat(document.getElementById('tradeValueFiatBuy').value);
    if (isNaN(fiatAmount / lastPrice)) {
        buyWindowCryptoAmount.value = 'BTC';
        buyTradeBtn.disabled = true;
      } else {
        const cryptoAmount = fiatAmount / lastPrice;
        if (cryptoAmount < 10) {
          buyWindowCryptoAmount.value = cryptoAmount.toFixed(4)
        } else {
          buyWindowCryptoAmount.value = cryptoAmount.toFixed(2)
        }

      if (buyWindowFiatAmount.value > userBalance) {
          document.querySelector('.buy-fiat-trade-warning-message').innerText = 'You have insufficient funds.';
          buyTradeBtn.disabled = true;
        } else {
          document.querySelector('.buy-fiat-trade-warning-message').innerText = '';
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
    buyTradeBtn.disabled = false;
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
    let cryptoBalance = parseFloat(document.querySelector('.user_crypto_balance').value);
    let cryptoName = document.getElementById('tradeValueCryptoSell').placeholder.split(' ')[0]
    if (cryptoBalance == 0) {
      document.getElementById('balance').innerText = `${cryptoName} ${cryptoBalance.toLocaleString(undefined, {minimumFractionDigits: 0, maximumFractionDigits: 0})}`;
    } else if (cryptoBalance < 10) {
      document.getElementById('balance').innerText = `${cryptoName} ${cryptoBalance.toLocaleString(undefined, {minimumFractionDigits: 4, maximumFractionDigits: 4})}`;
    } else {
      document.getElementById('balance').innerText = `${cryptoName} ${cryptoBalance.toLocaleString(undefined, {minimumFractionDigits: 0, maximumFractionDigits: 2})}`;
    }
    sellTradeBtn.disabled = true;
  })

  // THIS IS THE CODE IN THE SELL TO ON KEYUP DISPLAY THE AMOUNT YOU WILL RECEIVE AUTOMATICALLY

  sellWindowCryptoAmount.addEventListener('keyup', (event) => {
    let cryptoAmount = parseFloat(sellWindowCryptoAmount.value)
    // let cryptoBalance = parseFloat(document.querySelector('.user_crypto_balance').value)
    let cryptoName = document.getElementById('tradeValueCryptoSell').placeholder.split(' ')[0]
    if (isNaN(lastPrice * cryptoAmount)) {
      sellWindowFiatAmount.value = 'USD';
      sellTradeBtn.disabled = true;
    } else {
      sellWindowFiatAmount.value = lastPrice * cryptoAmount;
      if (cryptoAmount > cryptoBalance) {
        document.querySelector('.sell-crypto-trade-warning-message').innerText = `You have insufficient ${cryptoName}.`;
        sellTradeBtn.disabled = true;
        } else {
        document.querySelector('.sell-crypto-trade-warning-message').innerText = '';
        sellTradeBtn.disabled = false;
        };
    };
  });

  // THIS IS THE CODE IN THE SELL TO ON KEYUP DISPLAY THE AMOUNT OF CRYPTO THAT YOU WILL SELL AUTOMATICALLY
  sellWindowFiatAmount.addEventListener('keyup', (event) => {
    let fiatAmount = parseFloat(document.getElementById('tradeValueFiatSell').value);
    // let cryptoBalance = parseFloat(document.querySelector('.user_crypto_balance').value);
    let cryptoName = document.getElementById('tradeValueCryptoSell').placeholder.split(' ')[0]
    if (isNaN(fiatAmount / lastPrice)) {
      sellWindowCryptoAmount.value = cryptoName;
      sellTradeBtn.disabled = true;
    } else {
      sellWindowCryptoAmount.value = fiatAmount / lastPrice;
      if ((sellWindowFiatAmount.value / lastPrice) > cryptoBalance) {
        document.querySelector('.sell-fiat-trade-warning-message').innerText = `You have insufficient ${cryptoName}.`;
        sellTradeBtn.disabled = true;
        } else {
        document.querySelector('.sell-fiat-trade-warning-message').innerText = '';
        sellTradeBtn.disabled = false;
        };
    };
  });

  sellWindowFiatAmount.addEventListener('click', (event) => {
    sellWindowFiatAmount.value = '';
  });

  sellWindowCryptoAmount.addEventListener('click', (event) => {
    sellWindowCryptoAmount.value = '';
  });

  sellCyptoMaxBtn.addEventListener('click', (event) => {
    // let cryptoBalance = parseFloat(document.getElementById('crypto_amount_held').value);
    sellWindowCryptoAmount.value = cryptoBalance;
    sellWindowFiatAmount.value = cryptoBalance * lastPrice;
    sellTradeBtn.disabled = false;
  });

  sellFiatMaxBtn.addEventListener('click', (event) => {
    // let cryptoBalance = parseFloat(document.getElementById('crypto_amount_held').value);
    sellWindowCryptoAmount.value = cryptoBalance;
    sellWindowFiatAmount.value = cryptoBalance * lastPrice;
    sellTradeBtn.disabled = false;
  });
});

export { buyAndSellAnimations };
