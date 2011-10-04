class Parse

  def db_output(db_obj, default_hsh)
    array_output = Array.new
    
    db_obj.fetch do |row| 
      row_hsh = {row["date"] => row["visits"]} 
      default_hsh.merge!(row_hsh) 
    end

    default_hsh.each do |key, value| 
      array_output.push value 
    end 
    
    return array_output
    
  end

end