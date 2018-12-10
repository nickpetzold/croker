const authentication = '47368b5efe320de187b006d52cf7ee1be374fdd45b1af7495269e8c4b161f7cb';
const listOfCoins = ["BTC", "XRP", "ETH", "BCH", "EOS", "XLM", "USDT", "LTC", "XMR", "ADA", "TRX", "DASH", "BNB", "XEM", "ETC", "NEO", "ZEC", "BTG", "XTZ", "DOGE"];
const refreshButton = document.getElementById('btn-refresh')

refreshButton.addEventListener("click", (event) => {
    const targetCcy = listOfCoins.join(',');
    document.getElementById('exchange-table').innerHTML = '';
    const url = `https://min-api.cryptocompare.com/data/pricemulti?fsyms=USD,EUR,GBP&tsyms=${targetCcy},USD&api_key=` + authentication;
    fetch(url)
      .then(response => response.json())
      .then((data) => {
        listOfCoins.forEach((coin) => {
          const html = `<tr><th>${coin}</th><th>${(1 / data.USD[coin]).toFixed(2)}</th><th>${(1 / data.EUR[coin]).toFixed(2)}</th><th>${(1 / data.GBP[coin]).toFixed(2)}</th></tr>`;
          document.getElementById('exchange-table').insertAdjacentHTML('beforeend', html);
        });
    });
});




// const coins = require('coinlist');

// const coinArray = coins.map(coin => coin.symbol);
