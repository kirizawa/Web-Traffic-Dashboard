def get_chart_share(region)

  # Query data from mySQL
  # dates = get_dates(region)
  outcome_share = get_outcome_share(region)

  # Define Arrays and Hash
  seo_array = Array.new
  sem_array = Array.new
  direct_array = Array.new
  campaign_array = Array.new  
  social_array = Array.new
  referring_array = Array.new
  seo_hsh ={}
  sem_hsh = {}
  direct_hsh = {}
  campaign_hsh = {}
  social_hsh = {}
  referring_hsh = {}

  outcome_share.each do |row|
    # Build Hash with default value of 0 for all the given dates
    case row["dimension"] 
    when "Organic Search"
      @seo_string = "{name: 'Organic Search', data: [" + row["visits"].to_i.to_s + "," + row["pdp_visits"].to_i.to_s + "," + row["orders"].to_i.to_s + "," + row["revenue"].to_i.to_s + "]}"
      puts @seo_string
    when "Other Campaigns"
      @campaign_string = "{name: 'Campaign', data: [" + row["visits"].to_i.to_s + "," + row["pdp_visits"].to_i.to_s + "," + row["orders"].to_i.to_s + "," + row["revenue"].to_i.to_s + "]}"
      puts @campaign_string
    when "Paid Search"
      @sem_string = "{name: 'Paid Search', data: [" + row["visits"].to_i.to_s + "," + row["pdp_visits"].to_i.to_s + "," + row["orders"].to_i.to_s + "," + row["revenue"].to_i.to_s + "]}"
      puts @sem_string
    when "Referring Sites"
      @referring_string = "{name: 'Referring Sites', data: [" + row["visits"].to_i.to_s + "," + row["pdp_visits"].to_i.to_s + "," + row["orders"].to_i.to_s + "," + row["revenue"].to_i.to_s + "]}"
      puts @referring_string
    when "Social"
      @social_string = "{name: 'Social', data: [" + row["visits"].to_i.to_s + "," + row["pdp_visits"].to_i.to_s + "," + row["orders"].to_i.to_s + "," + row["revenue"].to_i.to_s + "]}"
      puts @social_string
    when "Unknown Referrer"
      @direct_string = "{name: 'Unkonwn Referrer', data: [" + row["visits"].to_i.to_s + "," + row["pdp_visits"].to_i.to_s + "," + row["orders"].to_i.to_s + "," + row["revenue"].to_i.to_s + "]}"
      puts @direct_string
    else
      puts "Undefines"
    end
  end
  
  # Overwrite default HiCharts values
  chart = HighChart.new(options={
    :render_to => "container_share",
    :title_text => "Traffic Source Performance - " + region,
    :sub_title => "Source: Webtrends",
    :x_categories => [ "Visits", "PDP Visits", "Orders", "Revenue"],
    :y_categories => "%",
    :series_data => "[" + @seo_string + ", " + @sem_string + ", " + @direct_string + ", " + @referring_string + ", " + @campaign_string + ", " + @social_string + "]"
  })
  
  return chart
  

end