//= require Chart.bundle
//= require chartkick
import "bootstrap";
import Chartkick from "chartkick";
window.Chartkick = Chartkick;
// for Chart.js
import Chart from "chart.js";
Chartkick.addAdapter(Chart);
Chart.defaults.scale.gridLines.display = false;
Chart.defaults.scale.xAxes.ticks.display = false;
