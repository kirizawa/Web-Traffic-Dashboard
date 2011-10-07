class HighChart 
  attr_accessor :render_to, :chart_type, :title_text, :sub_title, :x_categories, :y_categories, :series_name, :series_data

  def initialize(options={}) 
    self.render_to = options[:render_to] || 'container' 
    self.chart_type = options[:chart_type] || 'chart type'
    self.title_text = options[:title_text] || 'title text' 
    self.sub_title = options[:sub_title] || 'sub title'
    self.x_categories = options[:x_categories] || ['Apples','Bananas'] 
    self.y_categories = options[:y_categories] || 'Y Categories' 
    self.series_name = options[:series_name] || 'Series Name'
    self.series_data = options[:series_data] || '[ {name: "xxx", data: [1, 0, 4]}, {name: "zzz", data: [2,4,6]} ]'
  end
  
  def chart_js
    chart_js = "
  <script type='text/javascript'>
  var chart;
  $(document).ready(function() {
      chart = new Highcharts.Chart({
          chart: {
              renderTo: '#{render_to}',
              defaultSeriesType: 'line',
              marginRight: 130,
              marginBottom: 25
          },
          title: {
              text: '#{title_text}',
              x: -20
              //center
          },
          subtitle: {
              text: '#{sub_title}',
              x: -20
          },
          xAxis: {
              categories: #{x_categories},
  	      labels: {style: {color: '#fff'}}
          },
          yAxis: {
              title: {
                  text: '#{y_categories}'
              },
              plotLines: [{
                  value: 0,
                  width: 1,
                  color: '#808080'
              }]
          },
          tooltip: {
              formatter: function() {
                  return '<b>' + this.series.name + '</b><br/>' + this.x + ': ' + this.y + ' visits';
              }
          },
          legend: {
              layout: 'vertical',
              align: 'right',
              verticalAlign: 'center',
              x: 20,
              y: 100,
              borderWidth: 0
          },
          series: #{series_data}
      });
  });
  </script>
  "
  end
  
  def chart_stack_percent
    chart_share_js = "
    <script type='text/javascript'>
    var chart;
    $(document).ready(function() {
       chart = new Highcharts.Chart({
          chart: {
             renderTo: '#{render_to}',
             defaultSeriesType: 'column'
          },
          title: {
             text: '#{title_text}'
          },
          xAxis: {
             categories: #{x_categories}
          },
          yAxis: {
             min: 0,
             title: {
                text: 'Proportion (%)'
             }
          },
          tooltip: {
             formatter: function() {
                return ''+
                    this.series.name +': '+ this.y +' ('+ Math.round(this.percentage) +'%)';
             }
          },
          plotOptions: {
             column: {
                stacking: 'percent'
             }
          },
               series: #{series_data}
       });   
    });
    </script>
    "
  end
  
end
