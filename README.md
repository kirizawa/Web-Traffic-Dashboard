# **Web Traffic Dashboard**

Sample web based dashboard showing common web metrics.  

This example shows two charts:

1) Line chart broken down by different traffic sources

2) Stack bar graph showing shares of traffic, product page traffic, orders, and revenue for various traffic sources

# **Requirements**

Program works on MySQL with two tables containing web metrics.  DB schema and host info are defined in the variables defined in profile.  
Tables and metrics could be adjusted to your preference.  Here are the files to adjust

/lib/get_chart_shares.rb

/lib/get_chart_sources.rb

/lib/get_data.rb

I've defined the MySQL DB schema, user id, and password in profile.rb in profile, but you could change that accordingly.  Those values are obviously used to make connections to MySQL database.

# **How to use it?**

Start up the application

> ruby run_dashboard.rb

Go to your localhost with appropriate port number.  The first parameter in this example program is the regional value.  So it could look like:  http://localhost:1234/amr

Switch the regional parameter to reflect different regional data.

 

