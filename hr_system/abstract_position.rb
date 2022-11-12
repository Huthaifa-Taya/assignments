class AbstractPosition
  attr_accessor :employee_obj, :position
  @all_positions = %w[Owners Manager Lead Junior]
  @sal_grades = %w[High Competitive Good]
  @med_ins_types = [nil, "Family ", "Premium "]
  private_class_method :new

  def initialize(employee_record)
    @employee_obj = employee_record
    @position = employee_record.position.capitalize
  end

  def job_description
    puts "#{@employee_obj.name.capitalize} is a #{@position}, and updates #{@all_positions[@all_positions.index(@position) - 1]}"
  end

  def benefits
    puts "#{@sal_grades[@all_positions.index(@position) - 1]} salary"
    puts "#{@med_ins_types[@all_positions.index(@position) - 1]} Medical Insurance"
  end

end
