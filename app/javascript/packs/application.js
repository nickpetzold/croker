//= require Chart.bundle
//= require highcharts
import "bootstrap";
import { initCharts } from '../components/charts';
import { bindSweetAlertButtonDemo } from '../components/sweetalert';
import { removeFlashes } from '../components/removeFlashes';

import '../components/buysellcharts';

import { sortTable } from '../components/tablesort';

initCharts();
bindSweetAlertButtonDemo();
removeFlashes();
sortTable();


