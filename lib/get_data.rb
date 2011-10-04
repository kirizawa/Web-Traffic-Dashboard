require './profile/profile'
require 'dbi'

def get_daily_traffic(region, dimension)
  begin
    dbh = DBI.connect("DBI:Mysql:"+$db_schema+":localhost", $mysql_id, $mysql_id)
    sql = "select date_format(date,'%Y-%m-%d') AS date, dimension, sum(visits) visits 
    from " + $db_schema + ".logi_daily_source 
    where dimension = '" + dimension + "' 
    and region = '" + region + "'
    group by date, dimension
    order by date asc
    "
    #puts "SQL --> " + sql
    sth = dbh.execute(sql)
    return sth
    sth.finish
  rescue DBI::DatabaseError => e
    puts "An error occured"
    puts "Error code: #{e.err}"
    puts "Error message: #{e.errstr}"
  ensure 
    # disconnect from server
    dbh.disconnect if dbh
  end
end

def get_dates(region)
  begin
    dbh = DBI.connect("DBI:Mysql:"+$db_schema+":localhost", $mysql_id, $mysql_id)
    sql = "
    select date_format(date,'%Y-%m-%d') as date 
    from " + $db_schema + ".logi_daily_source
    where region = '" + region + "'
    group by date
    order by date asc
    "
    #puts "SQL --> " + sql
    sth = dbh.execute(sql)
    return sth
    sth.finish
  rescue DBI::DatabaseError => e
    puts "An error occured"
    puts "Error code: #{e.err}"
    puts "Error message: #{e.errstr}"
  ensure 
    # disconnect from server
    dbh.disconnect if dbh
  end
end
