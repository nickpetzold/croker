import Highcharts from 'highcharts';

const chartElement = document.getElementById('chart-container');

const getData = (id, timeframe) => (
  fetch(`http://localhost:3000/cryptocurrencies/${id}/chart/${timeframe}.json`)
  .then(response => response.json())
  .then((data) => {
    renderChart(data[0]);
  })
);

const renderChart = function(getData) {
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
        data: getData,
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

    const oneDayBtn = document.querySelector('.one-day');
    const oneWeekBtn = document.querySelector('.one-week');
    const oneMonthBtn = document.querySelector('.one-month');
    const oneYearBtn = document.querySelector('.one-year');
    const buttons = [oneDayBtn, oneWeekBtn, oneMonthBtn, oneYearBtn];
    const removeSelectedClass = (() => {
      buttons.forEach(function(x) {
        x.classList.remove('selected');
      });
    });

    getData(oneDayBtn.dataset.cryptoId, oneDayBtn.dataset.timeframe);

    buttons.forEach((button) => {
      button.addEventListener("click", function(event) {
       const cryptoId = event.target.dataset.cryptoId;
       const timeFrame = event.target.dataset.timeframe;

       getData(cryptoId, timeFrame);

       removeSelectedClass();
       button.classList.add('selected');
     });
    })
  }
};

export { initCharts };
