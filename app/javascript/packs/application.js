//= require Chart.bundle
//= require highcharts
import "bootstrap";
import { initCharts } from '../components/charts';
import { bindSweetAlertButtonDemo } from '../components/sweetalert';
import { removeFlashes } from '../components/removeFlashes';
import { initTables } from '../components/tablesort';
import { autocompleteSearch } from '../components/autocomplete';
import { toggleActiveClass } from '../components/toggleActiveClass';




import { buyAndSellAnimations } from '../components/buysellcharts';
import { javascriptTopUps } from '../components/javascriptTopUps';




bindSweetAlertButtonDemo();
removeFlashes();
initTables();
toggleActiveClass();
javascriptTopUps();



const path = window.location.pathname;
if (path == '/cryptocurrencies') {
  autocompleteSearch();
}

const href = window.location.href;
if (href.includes('cryptocurrencies?crypto_id')) {
  initCharts();
  buyAndSellAnimations();
}


