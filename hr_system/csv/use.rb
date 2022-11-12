require_relative 'CSVFileOperations'
require_relative 'csv_row'
class Use
  attr_accessor :csv_object, :file_name, :data, :data_array, :row_class

  def initialize (file_name, row_class)
    @row_class = row_class
    @file_name = file_name
    @csv_object = CSVFileOperations.new
    self.data_array = []
  end
  def read_file
    data = @csv_object.read_file file_name
    data.each { |row| @data_array.append @row_class.new row[:id], { first_name: row[:first_name], last_name: row[:last_name], age: row[:age], address: row[:address], position: row[:position], salary: row[:salary]} }
    @data_array
  end
  def write_data_file (data_row_array)
    raise TypeError, "Expected an array of objects of CSVRow class" unless data_row_array.is_a? Array and data_row_array.all? {|item| item.instance_of? @row_class}
    @csv_object.write_file file_name, data_row_array
  end
end


