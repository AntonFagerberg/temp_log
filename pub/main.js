(function () {
  loadSensor = function (sensor) {
    $('#graphs').html(
      '<h1>Sensor ' + sensor + '</h1>\
      <h2>Current temperature</h2>\
      <span id="current"></span>\
      \
      <h2>Hour</h2>\
      <canvas id="minuteChart" width="1000" height="300"></canvas>\
      \
      <h2>Today</h2>\
      <canvas id="todayChart" width="1000" height="300"></canvas>\
      \
      <h2>Yesterday</h2>\
      <canvas id="yesterdayChart" width="1000" height="300"></canvas>\
      \
      <h2>Weekly average</h2>\
      <canvas id="weekChart" width="1000" height="300"></canvas>\
      \
      <h2>Monthly average</h2>\
      <canvas id="monthChart" width="1000" height="300"></canvas>'
    );

    (function () {
      function tempFormat(temps) {
        return temps.map(function (temp) {
          // My sensor has +-0.5 degrees precision.
          return (Math.round(2 * temp / 1000) / 2).toFixed(1);
        });
      }

      function hourFormat(hours) {
        return hours.map(function (hour) {
          return ("0" + hour).substr(-2, 2);
        });
      }

      $.ajax("/api/" + sensor + "/current").done(function (response) {
        $("#current").empty().text(
          tempFormat(response.temp).reduce(function(_acc, temp) {
            return temp + "°C";
          }, "?")
        );
      });

      $.ajax("/api/" + sensor + "/minute").done(function (response) {
        var ctx = document.getElementById("minuteChart").getContext("2d");
        var data = {
            labels: response.minute,
            datasets: [
                {
                    label: "My Second dataset",
                    fillColor: "rgba(151,187,205,0.2)",
                    strokeColor: "rgba(151,187,205,1)",
                    pointColor: "rgba(151,187,205,1)",
                    pointStrokeColor: "#fff",
                    pointHighlightFill: "#fff",
                    pointHighlightStroke: "rgba(151,187,205,1)",
                    data: tempFormat(response.temp)
                }
            ]
        };
        var myLineChart = new Chart(ctx).Line(data);
      });

      $.ajax("/api/" + sensor + "/today").done(function (response) {
        var ctx = document.getElementById("todayChart").getContext("2d");
        var data = {
            labels: hourFormat(response.hour),
            datasets: [
                {
                    label: "My Second dataset",
                    fillColor: "rgba(151,187,205,0.2)",
                    strokeColor: "rgba(151,187,205,1)",
                    pointColor: "rgba(151,187,205,1)",
                    pointStrokeColor: "#fff",
                    pointHighlightFill: "#fff",
                    pointHighlightStroke: "rgba(151,187,205,1)",
                    data: tempFormat(response.temp)
                }
            ]
        };
        var myLineChart = new Chart(ctx).Line(data);
      });

      $.ajax("/api/" + sensor + "/yesterday").done(function (response) {
        var ctx = document.getElementById("yesterdayChart").getContext("2d");
        var data = {
            labels: hourFormat(response.hour),
            datasets: [
                {
                    label: "My Second dataset",
                    fillColor: "rgba(151,187,205,0.2)",
                    strokeColor: "rgba(151,187,205,1)",
                    pointColor: "rgba(151,187,205,1)",
                    pointStrokeColor: "#fff",
                    pointHighlightFill: "#fff",
                    pointHighlightStroke: "rgba(151,187,205,1)",
                    data: tempFormat(response.temp)
                }
            ]
        };
        var myLineChart = new Chart(ctx).Line(data);
      });

      $.ajax("/api/" + sensor + "/week").done(function (response) {
        var ctx = document.getElementById("weekChart").getContext("2d");
        var data = {
            labels: response.week,
            datasets: [
                {
                    label: "My Second dataset",
                    fillColor: "rgba(151,187,205,0.2)",
                    strokeColor: "rgba(151,187,205,1)",
                    pointColor: "rgba(151,187,205,1)",
                    pointStrokeColor: "#fff",
                    pointHighlightFill: "#fff",
                    pointHighlightStroke: "rgba(151,187,205,1)",
                    data: tempFormat(response.temp)
                }
            ]
        };
        var myLineChart = new Chart(ctx).Line(data);
      });

      $.ajax("/api/" + sensor + "/month").done(function (response) {
        monthNames = [
          "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dec"
        ];

        function monthFormat(months) {
          return months.map(function (month) {
            return monthNames[month - 1];
          });
        }

        var ctx = document.getElementById("monthChart").getContext("2d");
        var data = {
            labels: monthFormat(response.month),
            datasets: [
                {
                    label: "My Second dataset",
                    fillColor: "rgba(151,187,205,0.2)",
                    strokeColor: "rgba(151,187,205,1)",
                    pointColor: "rgba(151,187,205,1)",
                    pointStrokeColor: "#fff",
                    pointHighlightFill: "#fff",
                    pointHighlightStroke: "rgba(151,187,205,1)",
                    data: tempFormat(response.temp)
                }
            ]
        };
        var myLineChart = new Chart(ctx).Line(data);
      });
    })();
  };

  $.ajax("/api/sensors").done(function (response) {
    $("#sensors").html(
      response.sensors.reduce(function (acc, sensor) {
        return acc + "<button onclick='loadSensor(\"" + sensor + "\")'>" + sensor + "</button>";
      }, "Sensor: ")
    );
  });
})();
