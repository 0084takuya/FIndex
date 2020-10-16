function formatDate(date, format) {
  format = format.replace(/yyyy/g, date.getFullYear());
  format = format.replace(/MM/g, ("0" + (date.getMonth() + 1)).slice(-2));
  format = format.replace(/dd/g, ("0" + date.getDate()).slice(-2));
  format = format.replace(/HH/g, ("0" + date.getHours()).slice(-2));
  format = format.replace(/mm/g, ("0" + date.getMinutes()).slice(-2));
  format = format.replace(/ss/g, ("0" + date.getSeconds()).slice(-2));
  format = format.replace(/SSS/g, ("00" + date.getMilliseconds()).slice(-3));
  return format;
}

const chart_data = gon.data;
const options = gon.options;
const span = 7;
const item_count = 6;
const date_format = "MM/dd";
const dates = [];
const items = [];
const ctx = document.getElementById("player_chart").getContext("2d");

let min = options[2].min;
let max = options[2].max;

function setButtonAction(e) {
  var index = this.index;
  for (var i = 0; i < 6; i++) {
    items[i].classList.remove("chart-menu-item-selected");
  }

  items[index].classList.add("chart-menu-item-selected");

  min = options[index].min;
  max = options[index].max;
  
  drawChart();
}

function scaledTicksYAxisMax() {
  const yAxisMax = 10;
  const values = chart_data.map(d => d.y);
  return Math.max(...values) + yAxisMax;
}

function scaledTicksYAxisMin() {
  const yAxisMin = 10;
  const values = chart_data.map(d => d.y);
  return Math.min(...values) - yAxisMin;
}

function drawChart() {
  var chart = new Chart(ctx, {
    type: 'scatter',
    data: {
      datasets: [{
        pointRadius: 0,
        showLine: true,
        lineTension: 0,
        fill: true,
        borderColor: "rgba(5, 255, 0, 1)",
        backgroundColor: "rgba(56, 66, 60, 1)",
        borderWidth: 2,
        data: chart_data
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      legend: {
        display: false
      },
      scales:{
        xAxes: [{
          gridLines: { 
            color: "rgba(100, 100, 100, 0.6)",
          },
          type: 'time',
          time: {
            unit: 'hour',
            displayFormats: {
              hour: 'MM/DD hh:mm'
            },
            min: min,
            max: max,
          },
          ticks: {
            maxRotation: 0,
            minRotation: 0,
            fontColor: "rgba(220, 220, 220, 1)",
            autoSkip: true,
            maxTicksLimit: 6
          }
        }],
        yAxes: [{
          position: "right",
          gridLines: {
            color: "rgba(100, 100, 100, 0.6)",
          },
          ticks: {
            fontColor: "rgba(220, 220, 220, 1)",
            reverse: false,
            max: scaledTicksYAxisMax(),
            min: scaledTicksYAxisMin(),
          }
        }]
      }
    }
  });
}

$(function () {
  for (var i = 0; i < 6; i++) {
    var item_i = document.getElementById("chart_menu_item_" + String(i));
    item_i.addEventListener("click", {
      index: i, handleEvent: setButtonAction
    });
    items.push(item_i);
  }

  drawChart();
});
