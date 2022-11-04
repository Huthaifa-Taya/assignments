require "./rent_assignment/Vehicle"

class Car < Vehicle
  def initialize
    super
    @rent_price = 50
  end
end

class Van < Vehicle
  def initialize
    super
    @rent_price = 70
  end
end

class MotorCycle < Vehicle
  def initialize
    super
    @rent_price = 20
  end
end