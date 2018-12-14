/**
 * 
 */

 // Load Charts and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Draw the pie chart for Sarah's pizza when Charts is loaded.
      google.charts.setOnLoadCallback(drawSarahChart);

      function drawSarahChart() {

        // Create the data table for Sarah's pizza.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Topping');
        data.addColumn('number', 'Slices');
        data.addRows([
          ['Mushrooms', 5],
          ['Onions', 2],
          ['Olives', 1],
          ['Zucchini', 4],
          ['Pepperoni', 1]
        ]);

        // Set options for Sarah's pie chart.
        var options = {title:'Sell of Pizza at last night',
                       width:500,
                       height:400};

        // Instantiate and draw the chart for Sarah's pizza.
        var chart = new google.visualization.PieChart(document.getElementById('Sarah_chart_div'));
        chart.draw(data, options);
      }

     //.......................................................................
       google.charts.load('current', {  'packages':['geochart'],
        // Note: you will need to get a mapsApiKey for your project.
        // See: https://developers.google.com/chart/interactive/docs/basic_load_libs#load-settings
        'mapsApiKey': 'AIzaSyD-9tSrke72PouQMnMX-a7eZSW0jkFMBWY'
      });
      google.charts.setOnLoadCallback(drawRegionsMap);

      function drawRegionsMap() {
        var data = google.visualization.arrayToDataTable([
          ['Country', 'Sell'],
          ['Germany', 200],
          ['United States', 300],
          ['Brazil', 400],
          ['Canada', 500],
          ['France', 600],
          ['RU', 700],
          ['India',900]
        ]);

        var options = {};

        var chart = new google.visualization.GeoChart(document.getElementById('regions_div'));

        chart.draw(data, options);
      }
      
      
      
      //...............................................
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawChartBar);

      function drawChartBar() {
        var data = google.visualization.arrayToDataTable([
          ['Year', 'Sales', 'Expenses', 'Profit'],
          ['2014', 500, 400, 900],
          ['2015', 1770, 460, 1250],
          ['2016', 160, 120, 1300],
          ['2017', 530, 540, 350]
        ]);

        var options = {
          chart: {
            title: 'Company Performance',
            subtitle: 'Sales, Expenses, and Profit: 2014-2017',
          },
          bars: 'vertical',
          width:400,
          height:500
          // Required for Material Bar Charts.
        };

        var chart = new google.charts.Bar(document.getElementById('barchart_material'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
      //............................
      google.charts.load('current', {'packages':['line']});
      google.charts.setOnLoadCallback(drawChart);

    function drawChart() {

      var data = new google.visualization.DataTable();
      data.addColumn('number', 'Day');
      data.addColumn('number', 'Movie1');
      data.addColumn('number', 'Movie2');
      data.addColumn('number', 'Movie3');

      data.addRows([
        [1,  7.8, 10.8, 41.8],
        [2,  30.9, 49.5, 32.4],
        [3,  25.4,  10, 5.7],
        [4,  11.7, 18.8, 10.5],
        [5,  11.9, 17.6, 10.4],
        [6,   28.8, 13.6,  7.7],
        [7,   7.6, 12.3,  9.6],
        [8,  12.3, 29.2, 60.6],
        [9,  16.9, 42.9, 14.8],
        [10, 72.8, 30.9, 11.6]
       
      ]);

      var options = {
        chart: {
          title: 'Box Office Earnings ',
          subtitle: 'in millions of dollars (USD)'
        },
        width: 450,
        height: 500
      };

      var chart = new google.charts.Line(document.getElementById('linechart_material'));

      chart.draw(data, google.charts.Line.convertOptions(options));
    }