require_relative './exceptions/data_not_set_error'

class Form
  attr_accessor :fields, :data

  def initialize
    @fields = Hash.new
    @data = Hash.new
  end

  def get_inputs
    raise DataNotSetError.new "has no data", "fields" unless @fields.length > 0
    @fields.each do |field_key, field_value|
      puts "Enter the #{field_key.to_s}"
      @data[field_key] = @fields[field_key] == Integer ? gets.chomp.to_i : gets.chomp
    end
    @data
  end
end
