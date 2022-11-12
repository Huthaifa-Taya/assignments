require_relative 'hr'
require_relative 'form'
require_relative 'employee'
require_relative 'csv/use'
form_object = Form.new
csv_object = Use.new "./hr_system/data/employees.csv", EmployeeRecord
hr_system = HRSystem.instance
hr_system.start form_object, EmployeeRecord, csv_object
