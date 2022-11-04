require "./rent_assignment/Vehicles"
require './rent_assignment/Customer'
class Rent
  attr_accessor :motor_cycle
  attr_accessor :car
  attr_accessor :van
  attr_accessor :customer
  attr_accessor :chosen_vehicle
  attr_accessor :desired_rent_period
  attr_reader   :vehicles_array
  attr_accessor :period_discounts
  attr_accessor :periods
  def initialize
    super
    @motor_cycle = MotorCycle.new
    @car = Car.new
    @van = Van.new
    @vehicles_array = [@motor_cycle, @car, @van]
    @periods = {"a": "3 to 5", "b": "6 to 10", "c": "more than 10"}
    @period_discounts = {a: 0.1, b: 0.3, c: 0.4 }
    @customer = Customer.new(get_customer_name)
    new_customer #upon instantiating a new object starts the process
  end

  def get_customer_name
    puts "Welcome to the secret shop!"
    print "please enter your name: "
    gets.chomp
  end

  def new_customer
    customer_welcoming @customer&.name
    show_rent_options
    select_vehicle
    puts "We are having a special discount just for you!."
    select_rent_period
    calc_cost_verify
  end

  def customer_welcoming (customer_name)
    puts "Hello #{customer_name}.\nWelcome to our rent shop.\nWe have plenty of choices for you to choose."
  end

  def show_rent_options
    puts "There are three available renting choices:"
    @vehicles_array.each_with_index {|vehicle, index| puts "#{index + 1}- #{vehicle.class}: renting price per day is #{vehicle.rent_price}"}
  end

  def select_vehicle
    puts "Please enter the number of the desired vehicle"
    choice_number = gets.chomp.to_i - 1
    unless (0 ... @vehicles_array.length).include? choice_number
      puts "Invalid choice please enter a valid corresponding vehicle number"
      select_vehicle
    end
    @chosen_vehicle = @vehicles_array[choice_number]
    puts @chosen_vehicle
  end

  def select_rent_period
    ("a".."c").each {|index_character| puts "if you rent a #{@chosen_vehicle.class} for #{@periods[index_character.to_sym]} days, you'll have a #{@period_discounts[index_character.to_sym]} discount"}
    puts "Please enter the desired renting duration."
    entered_rent_period = gets.chomp.to_i
    unless entered_rent_period > 0
      puts "please enter a valid number for the desired rent duration"
      select_rent_period
    end
    @desired_rent_period = entered_rent_period
  end

  def calc_cost_verify
    discount_factor = 1
    case @desired_rent_period
    when 1..2
      pass
    when 3..5
      discount_factor = 0.9
    when 6..10
      discount_factor = 0.7
    else
      discount_factor = 0.6
    end
    total_price = @chosen_vehicle&.rent_price * @desired_rent_period
    puts "You have chosen to rent a #{@chosen_vehicle&.class} for #{@desired_rent_period} days.\ntotal rent cost is #{total_price}\nDiscount amount is: #{total_price * (1 - discount_factor)}\nNet price is: #{total_price * discount_factor}\nDo you want to confirm your rent?\nType 'Yes' to continue 'No' to cancel."
    agree_to_rent_answer = gets.chomp
    start_over unless agree_to_rent_answer.downcase == 'yes'
  end

  def start_over
    show_rent_options
    select_vehicle
    puts "We are having a special discount just for you!."
    select_rent_period
    calc_cost_verify
  end
end
