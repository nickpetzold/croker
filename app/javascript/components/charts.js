import Highcharts from 'highcharts';

const chartElement = document.getElementById('chart-container');

const renderChart = function(data) {
     Highcharts.chart(chartElement, {

      chart: {
        type: 'area'
      },

      title: {
        text: ''
      },

      xAxis: {
        visible : false,
        type: 'datetime',
        labels: {
          format: '{value:%Y-%b-%e}'
        },
      },

      yAxis: {
        visible : false
      },

      tooltip: {
        pointFormat: 'USD{point.y}',
        shared: true
      },

      legend: {
        enabled: false
      },
      series: [{
        name : "|",
        data: data,
        lineColor: '#60cd44',
        color: '#60cd44',
        fillOpacity: 0.5,
        marker: {
          enabled: false
        },
        threshold: null
      }]

    });
}

const initCharts = function() {

  if (chartElement) {
    const data = JSON.parse(chartElement.dataset.historicalPrices);
    const oneDayBtn = document.getElementById('one-day');
    const oneWeekBtn = document.getElementById('one-week');
    const oneMonthBtn = document.getElementById('one-month');
    const oneYearBtn = document.getElementById('one-year');
    oneDayBtn.addEventListener("click", function(event) {
      renderChart(data[3]);
    });
    oneWeekBtn.addEventListener("click", function(event) {
      renderChart(data[2]);
    });
    oneMonthBtn.addEventListener("click", function(event) {
      renderChart(data[1]);
    });
    oneYearBtn.addEventListener("click", function(event) {
      renderChart(data[0]);
    });
    renderChart(data[0]);

  }
};

export { initCharts };
