class CSVRow
  attr_accessor :product_id, :product_name, :product_price

  def initialize(id, name, price)
    @product_id = id
    @product_name = name
    @product_price = price
  end
end
