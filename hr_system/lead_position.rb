require_relative 'abstract_position'
require_relative 'meetings'

class LeadPosition < AbstractPosition
  extend Meetings

  def initialize(employee_record)
    super
    @meeting_type = "Team"
  end

  def job_description
    super
    puts "Handles Team members", "Team meeting"
  end

  def benefits
    super
    puts "Yearly bonus"
  end
end
