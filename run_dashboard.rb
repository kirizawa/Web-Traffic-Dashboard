#!/usr/bin/env ruby
require './lib/get_data'
require './lib/chart_js'
require './lib/parse_data'
require './lib/get_chart_sources'
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
  
  chart = get_chart_sources(region, dimensions)
  
  # assign high charts js output to ling_chart  
  line_chart = chart.chart_js
    
  haml :traffic, :locals => { :region => region, :charts => line_chart} 
end

