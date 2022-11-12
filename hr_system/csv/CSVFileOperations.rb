require 'csv'
class CSVFileOperations
  def read_file (file_name)
    CSV.open file_name, headers: true, header_converters: :symbol
  end

  def write_file (file_name, data)
    CSV.open file_name, 'w' do |csv|
      csv << %w[id first_name last_name age address position salary]
      data.each { |row| csv << [row.id, row.first_name, row.last_name, row.age, row.address, row.position, row.salary] }
      csv.close
    end

  end
end
