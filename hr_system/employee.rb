class EmployeeRecord
  attr_accessor :id, :first_name, :last_name, :age, :position, :address, :salary

  def initialize(id, pers_data_obj)
    @id = id
    @first_name = pers_data_obj[:first_name]
    @last_name = pers_data_obj[:last_name]
    @age = pers_data_obj[:age]
    @address = pers_data_obj[:address]
    @position = pers_data_obj[:position]
    @salary = pers_data_obj[:salary]
  end
end