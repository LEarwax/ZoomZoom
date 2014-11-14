require_relative "../models/edmunds"
require_relative "../view/view"
require_relative "../../config/environment"
require 'pp'

module Controller
  def self.run
    View.welcome_message
    View.render("What do you want to do?")
    View.list(["add", "list","delete"])
    command = gets.chomp.to_i
    case command
    when 1
      View.render("What year is the car?")
      year = gets.chomp.to_i
      data = Edmunds.run(year)
      Car.create(data)
    when 2
      cars = Car.all
      cars.each { |car| puts "#{car.year} #{car.make} #{car.model} MPG: #{car.mpg_combined} Horsepower: #{car.horsepower} Torque: #{car.torque} Weight: #{car.weight} 0-60: #{car.zero_2_sixty}"}
    when 3
      puts "Which car woudl you like to delete?"
      Car.all.each { |car| puts "#{car.id}. #{car.year} #{car.make} #{car.model}"}
      car_id = gets.chomp.to_i
      Car.find(car_id).destroy
    else
      "Sorry that's not a command!"
    end
  end


Controller.run
  # View.render("What do you want to do?")
  # View.list(["login", "create"])




  # input = gets.chomp.to_i

  # if input == 1
  #   View.render("What's your name?")
  #   name = gets.chomp
  #   lookup_user(name)
  # elsif input == 2
  #   create_user
  # end



  # def create(input)

  # end

  # def create_user(input)
  #   if input
  # end

  # def lookup_user(name)
  #   name = Driver.find_by(name: name)
  #   if name.nil?
  #     View.render("Sorry, this user does not exist")
  #   else
  #     View.render("Welcome #{name}!")
  #   end
  # end

  # def add_car
  # end

  # def display_cars
  # end

  # def delete_car
  # end

end
