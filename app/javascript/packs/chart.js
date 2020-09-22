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

$(function () {
  var histories = gon.change_histories;

  var labels = [];
  var span = 7;
  var date_format = "MM/dd";
  var dates = [];

  for (var i = 4; i >= 0; i--) {
    var date = new Date();
    date.setDate(date.getDate() - span * i);
    dates.push(formatDate(date, date_format));
  }

  for (var i = 0; i < 29; i++) {
    if (i % span == 0) {
      labels.push(dates[0]);
      dates.shift();
    } else {
      labels.push("");
    }
  }

  var chart_data = gon.chart_data;

  var ctx = document.getElementById("player_chart").getContext("2d");
  var chart = new Chart(ctx, {
    type: "line",

    data: {
      labels: labels,
      datasets: [
        {
          backgroundColor: "rgba(56, 66, 60, 1)",
          borderColor: "rgba(5, 255, 0, 1)",
          data: chart_data,
        },
      ],
    },

    options: {
      maintainAspectRatio: false,
      legend: {
        display: false,
      },
      scales: {
        yAxes: [
          {
            position: "right",
            ticks: {
              fontColor: "white",
              fontSize: 10,
              beginAtZero: true,
            },
          },
        ],
        xAxes: [
          {
            ticks: {
              fontColor: "white",
              fontSize: 10,
            },
          },
        ],
      },
      layout: {
        padding: {
          left: 20,
          right: 10,
          top: 20,
          bottom: 10,
        },
      },
    },
  });
});
