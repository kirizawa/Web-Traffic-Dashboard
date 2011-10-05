def get_chart_sources(region, dimensions)

  # Query data from mySQL
  dates = get_dates(region)
  seo_data = get_daily_traffic(region, dimensions[0])
  sem_data = get_daily_traffic(region, dimensions[1])
  direct_data = get_daily_traffic(region, dimensions[2])
  referring_data = get_daily_traffic(region, dimensions[3])
  campaign_data = get_daily_traffic(region, dimensions[4])
  social_data = get_daily_traffic(region, dimensions[5])


  # Define Arrays and Hash
  days = Array.new
  seo_visits = Array.new   
  sem_visits = Array.new   
  direct_visits = Array.new
  referring_viists = Array.new
  campaign_visits = Array.new
  social_visits = Array.new
  seo_output_hsh = {}
  sem_output_hsh = {}
  direct_output_hsh = {}
  referring_output_hsh = {}
  campaign_output_hsh = {}
  social_output_hsh = {}

  dates.each do |day|
    # Push list of dates into days array for x-categories in HiCharts
    days.push day["date"]
    # Build Hash with default value of 0 for all the given dates
    seo_output_hsh = seo_output_hsh.merge(day["date"] => 0)
    sem_output_hsh = sem_output_hsh.merge(day["date"] => 0)
    direct_output_hsh = direct_output_hsh.merge(day["date"] => 0)
    referring_output_hsh = referring_output_hsh.merge(day["date"] => 0)
    campaign_output_hsh = campaign_output_hsh.merge(day["date"] => 0)
    social_output_hsh = social_output_hsh.merge(day["date"] => 0)
  end

  # Call instance method from Parse class and pass DBI object to return array
  sem_visits = db_output(sem_data, sem_output_hsh)
  seo_visits = db_output(seo_data, seo_output_hsh)
  direct_visits = db_output(direct_data, direct_output_hsh)
  referring_visits = db_output(referring_data, referring_output_hsh)
  campaign_visits = db_output(campaign_data, campaign_output_hsh)
  social_visits = db_output(social_data, social_output_hsh)

  # Building data string for highcharts series values
  seo_string = "{name: '" + dimensions[0] + "', data: [" + seo_visits.join(',').to_s + "]}"
  sem_string = "{name: '" + dimensions[1] + "', data: [" + sem_visits.join(',').to_s + "]}"
  direct_string = "{name: '" + dimensions[2] + "', data: [" + direct_visits.join(',').to_s + "]}"
  referring_string = "{name: '" + dimensions[3] + "', data: [" + referring_visits.join(',').to_s + "]}"
  campaign_string = "{name: '" + dimensions[4] + "', data: [" + campaign_visits.join(',').to_s + "]}"
  social_string = "{name: '" + dimensions[5] + "', data: [" + social_visits.join(',').to_s + "]}"

  # Overwrite default HiCharts values
  chart = HighChart.new(options={
    :render_to => "container",
    :title_text => "Traffic by Sources - " + region,
    :sub_title => "Source: Webtrends",
    :x_categories => days,
    :y_categories => "Traffic (visits)",
    :series_data => "[" + seo_string + ", " + sem_string + ", " + direct_string + ", " + referring_string + ", " + campaign_string + ", " + social_string + "]"
  })
  
  return chart
  
end