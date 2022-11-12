require_relative 'abstract_position'
class JuniorPosition < AbstractPosition
  def job_description
    super
    puts "Handles daily tasks"
  end
end
