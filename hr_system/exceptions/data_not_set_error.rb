class DataNotSetError < StandardError
  def initialize(msg = nil, variable_name)
    print "\"#{variable_name}\" ", msg
    puts "\nupdate \"#{variable_name}\" before performing any operation."
    super msg
  end
end
