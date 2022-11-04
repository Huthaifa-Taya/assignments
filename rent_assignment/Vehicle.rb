class Vehicle
  attr_accessor :rent_price
  attr_accessor :rent_period

  def self.new(*args)
    raise NoMethodError, "cannot instantiate #{self.name}" if self == Vehicle
    super
  end
end