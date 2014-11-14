module View
  def self.render(message)
    puts message
  end

  def self.list(array)
    array.each_with_index {|item, index| puts "#{index + 1}. #{item}"}
  end

  def self.cars(cars)
    cars.each{|car| "#{car.year} #{car.make} #{car.model}"}
  end
end
