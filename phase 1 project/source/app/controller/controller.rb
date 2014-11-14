require_relative "../models/edmunds"
require_relative "../view/view"
require_relative "../../config/environment"

module Controller
  def self.run
    View.render("Welcome to Zoom Zoom!!!")
    puts "What do you want to do:"
    puts "(add)"
    puts "(list)"
    command = gets.chomp
    case command
    when 'add'
      puts "What year is the car?"
      year = gets.chomp
      data = Edmunds.run(year.to_i)
      Car.create(data)
    when 'list'
      Car.all.each{|car| puts "#{car.year} #{car.make} #{car.model}"}
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
