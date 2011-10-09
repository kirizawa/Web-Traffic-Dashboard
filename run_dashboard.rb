#!/usr/bin/env ruby
require './lib/get_data'
require './lib/chart_js'
require './lib/parse_data'
require './lib/get_chart_sources'
require './lib/get_chart_share'
require 'sinatra'
require 'haml'

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
  
  # create and assign high charts js output to ling_chart  
  chart = get_chart_sources(region, dimensions)
  line_chart = chart.chart_js
  
  # create and assign high charts js output for stack percentage columns stack_chart
  chart_share = get_chart_share(region)
  stack_chart = chart_share.chart_stack_percent
    
  haml :traffic, :locals => { :region => region, :charts => line_chart, :stack_charts => stack_chart} 
end

