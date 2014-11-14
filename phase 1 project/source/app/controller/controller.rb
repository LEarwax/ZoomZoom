module Controller
  View.render("Welcome to Zoom Zoom!!!")

  def self.run
    command = ARGV[0]
    case command
    when 'add'
      data = Edmunds.run(ARGV[1])
      Car.create(data)
    when 'list'
      View.cars(Car.all)
    else
      "Sorry that's not a command!"
    end
  end

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
