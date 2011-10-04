#!/usr/bin/env ruby
require './lib/get_data'
require './lib/chart_js'
require './lib/parse_data'
require 'sinatra'
require 'haml'
require 'dbi'

# set :public, Proc.new { File.join(root, "js") }
set :views, File.join(File.dirname(__FILE__), 'views')
set :static, true
set :public, 'public'

#==========================================
#  Index Page
#==========================================
get '/' do
  charts = ""
  haml :index, :locals => { :charts => charts}
end

#==========================================
#  Traffic Sources Report by Region
#==========================================
get '/:region' do|region|
  
  # Traffic Sources to pull from DB
  dimensions = ["Organic Search", "Paid Search", "Unknown Referrer", "Referring Sites", "Other Campaigns", "Social"]
  
  # Query data from mySQL
  dates = get_dates(region)
  seo_data = get_daily_traffic(region, dimensions[0])
  sem_data = get_daily_traffic(region, dimensions[1])
  direct_data = get_daily_traffic(region, dimensions[2])
  referring_data = get_daily_traffic(region, dimensions[3])
  campaign_data = get_daily_traffic(region, dimensions[4])
  
  # Define Arrays and Hash
  days = Array.new
  seo_visits = Array.new   
  sem_visits = Array.new   
  direct_visits = Array.new
  referring_viists = Array.new
  campaign_visits = Array.new
  default_output_hsh = {}
  
  dates.each do |day|
    # Push list of dates into days array for x-categories in HiCharts
    days.push day["date"]
    # Build Hash with default value of 0 for all the given dates
    default_output_hsh = default_output_hsh.merge(day["date"] => 0)
  end

  # Call instance method from Parse class and pass DBI object to return array
  sem_visits = Parse.new.db_output(sem_data, default_output_hsh)
  seo_visits = Parse.new.db_output(seo_data, default_output_hsh)
  direct_visits = Parse.new.db_output(direct_data, default_output_hsh)
  referring_visits = Parse.new.db_output(referring_data, default_output_hsh)
  campaign_visits = Parse.new.db_output(campaign_data, default_output_hsh)
  
  # Building data string for highcharts series values
  seo_string = "{name: '" + dimensions[0] + "', data: [" + seo_visits.join(',').to_s + "]}"
  sem_string = "{name: '" + dimensions[1] + "', data: [" + sem_visits.join(',').to_s + "]}"
  direct_string = "{name: '" + dimensions[2] + "', data: [" + direct_visits.join(',').to_s + "]}"
  referring_string = "{name: '" + dimensions[3] + "', data: [" + referring_visits.join(',').to_s + "]}"
  campaign_string = "{name: '" + dimensions[4] + "', data: [" + campaign_visits.join(',').to_s + "]}"
  
  # Overwrite default HiCharts values
  @chart = HighChart.new(options={
                :render_to => "container",
                :title_text => "Traffic by Sources - " + region,
                :sub_title => "Source: Webtrends",
                :x_categories => days,
                :y_categories => "Traffic (visits)",
                :series_data => "[" + seo_string + ", " + sem_string + ", " + direct_string + ", " + referring_string + ", " + campaign_string + "]"
              }
            )

  # assign high charts js output to ling_chart  
  line_chart = @chart.chart_js
    
  haml :traffic, :locals => { :region => region, :data => sem_visits, :charts => line_chart} 
end

