require_relative 'abstract_position'
require_relative 'meetings'

class ManagerPosition < AbstractPosition
  extend Meetings

  def initialize(employee_record)
    super
    @meeting_type = "Board"
  end

  def job_description
    super
    puts "Handles Management tasks", "Board Meeting"
  end

  def benefits
    super
    puts "High raise"
  end
end
