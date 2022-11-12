require_relative 'manager_position'
require_relative 'lead_position'
require_relative 'junior_position'
require 'securerandom'
require_relative 'exceptions/data_not_set_error'

class HRSystem
  @instance
  private_class_method :new #make HRSystem a singleton
  attr_reader :employees, :employee_record_obj, :fields, :form_obj, :emp_rec_class, :csv_object

  def initialize
    @employees = { all: {}, manager: {}, leader: {}, junior: {} } #hash data structure to categorize employees by their position
    @fields = {first_name: String, last_name: String, age: Integer, address: String, position: String, salary: Integer} #fields required for
  end

  def self.instance
    @instance = self.new unless @instance != nil
    @instance
  end

  def invoke_operation(selection)
    case selection
    when 1
      new_employee
    when 2
      save_employees
    when 3
      read_employees
    when 4
      view_managers
    when 5
      view_team_leads
    when 6
      view_juniors
    when 7
      view_all
    end
    prompt_operations
  end

  def start(form_obj, emp_rec_class, csv_object)
    @emp_rec_class = emp_rec_class
    @form_obj = form_obj
    @csv_object = csv_object
    prompt_operations
  end

  def prompt_operations
    puts "Select the operation you want to execute.\n1. create a new user.\n2. save created employees to file.\n3. read employees from file.\n4. view managers\n5. view team leaders.\n6. view juniors.\n7. view all employees"
    user_selection = gets.chomp.to_i
    unless user_selection > 0 and user_selection < 8
      system "cls"
      puts "Invalid selection please enter a valid option number.\n\n"
      prompt_operations
    end
    invoke_operation user_selection
  end

  private
  def new_employee #new employee method.
    new_uniq_id = SecureRandom.uuid #unique id for each employee.
    _exit = false #exception retry breaking flag (if true breaks out of retry).
    @form_obj&.fields= @fields
    begin
      #Uses form class to get the desired fields values return value is a hash, get_inputs method requires hash of fields with their types.
      emp_prsn_data = @form_obj.get_inputs unless _exit
    rescue DataNotSetError => error
      puts error, "Enter cancel to exit process, enter to retry"
      _exit = gets.chomp.downcase == "cancel"
      retry
    end
    #creates new employee record from the form data along with unique id.
    @employee_record_obj = @emp_rec_class.new new_uniq_id, emp_prsn_data
    #appends the new employee data record to the all employees key of the employee hash.
    @employees[:all][@employee_record_obj.id.to_sym] = @employee_record_obj
    #appends the new employee data record to its according key in the employee hash based on position of the employee
    case employee_record_obj.position.downcase
    when "manager"
      @employees[:manager][@employee_record_obj.id.to_sym] = @employee_record_obj
    when "leader"
      @employees[:leader][@employee_record_obj.id.to_sym] = @employee_record_obj
    when "junior"
      @employees[:junior][@employee_record_obj.id.to_sym] = @employee_record_obj
    else
      abort "Something went wrong, employee position is invalid try again please."
    end
  end

  def save_employees
    @csv_object.write_data_file employees[:all].values
    puts employees[:all].values
  end

  def read_employees
    @csv_object.read_file.each do |row|
      @employees[:all].store row.id, row
      pos = row.position.to_sym
      @employees[pos].store row.id.to_sym, row
    end
    print "\n#{employees}\n"
  end

  def view_all
    puts "id\t\t\t\t\tfirst name\t\t\tlast name\t\tage\t\taddress\t\t\t\tposition\t\t\tsalary"
    @employees[:all].values.each { |employee| puts "#{employee.id}\t#{employee.first_name}\t\t\t#{employee.last_name}\t\t\t#{employee.age}\t\t#{employee.address}\t\t\t\t#{employee.position}\t\t\t#{employee.salary}" }
    end
  def view_managers
    puts "id\t\t\t\t\tfirst name\t\t\tlast name\t\tage\t\taddress\t\t\t\tposition\t\t\tsalary"
    @employees[:manager].values.each { |employee| puts "#{employee.id}\t#{employee.first_name}\t\t\t#{employee.last_name}\t\t\t#{employee.age}\t\t#{employee.address}\t\t\t\t#{employee.position}\t\t\t#{employee.salary}" }
    end
  def view_team_leads
    puts "id\t\t\t\t\tfirst name\t\t\tlast name\t\tage\t\taddress\t\t\t\tposition\t\t\tsalary"
    @employees[:leader].values.each { |employee| puts "#{employee.id}\t#{employee.first_name}\t\t\t#{employee.last_name}\t\t\t#{employee.age}\t\t#{employee.address}\t\t\t\t#{employee.position}\t\t\t#{employee.salary}" }
    end
  def view_juniors
    puts "id\t\t\t\t\tfirst name\t\t\tlast name\t\tage\t\taddress\t\t\t\tposition\t\t\tsalary"
    @employees[:junior].values.each { |employee| puts "#{employee.id}\t#{employee.first_name}\t\t\t#{employee.last_name}\t\t\t#{employee.age}\t\t#{employee.address}\t\t\t\t#{employee.position}\t\t\t#{employee.salary}" }
  end
end
