//= require Chart.bundle
//= require chartkick
import "bootstrap";
import Chartkick from "chartkick";
window.Chartkick = Chartkick;
// for Chart.js
// import Chart from "chart.js";
// Chartkick.addAdapter(Chart);


// for Highcharts
import Highcharts from "highcharts";
Chartkick.addAdapter(Highcharts);
Chart.defaults.global.animation = true;
// Chart.options.xAxis.labels.enabled = false;
// Chart.defaults.scale.gridLines.display = false;

// Chart.defaults.global
