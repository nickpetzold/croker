import 'js-autocomplete/auto-complete.css';
import autocomplete from 'js-autocomplete';

const autocompleteSearch = function() {
  const cryptos = JSON.parse(document.getElementById('search-data').dataset.cryptocurrencies);
  console.log(cryptos);
  const cryptoComplete = [];
  cryptos.forEach((x) => {
    cryptoComplete.push(x.ticker_name);
  })
  console.log(cryptoComplete);
  const searchInput = document.getElementById('q');

  if (cryptos && searchInput) {
    new autocomplete({
      selector: searchInput,
      minChars: 1,
      source: function(term, suggest){
          term = term.toLowerCase();
          const choices = cryptos;
          const matches = [];
          for (let i = 0; i < choices.length; i++)
              if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
          suggest(matches);
      },
    });
  }
};

export { autocompleteSearch };
