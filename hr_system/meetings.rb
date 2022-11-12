module Meetings
  attr_accessor :meeting_type

  def job_description
    puts "#{@meeting_type} meeting"
  end

end
