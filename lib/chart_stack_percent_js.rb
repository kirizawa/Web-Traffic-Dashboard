class HighChart_StackP
  attr_accessor :render_to, :chart_type, :title_text, :x_categories, :y_categories, :series_name, :series_data

  def initialize(options={}) 
    self.render_to = options[:render_to] || 'container_stach_p' 
    self.chart_type = options[:chart_type] || 'column'
    self.title_text = options[:title_text] || 'Title Text' 
    self.x_categories = options[:x_categories] || ['Apples','Bananas'] 
    self.y_categories = options[:y_categories] || 'Y Categories' 
    self.series_name = options[:series_name] || 'Series Name'
    self.series_data = options[:series_data] || '[ {name: "xxx", data: [1, 0, 4]}, {name: "zzz", data: [2,4,6]} ]'
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



