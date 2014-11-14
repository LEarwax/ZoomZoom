require 'net/http'
require 'json'

module View
  def self.clear_screen
    print "\e[2J"
    print "\e[H"
  end
end

module Edmunds

  def self.get_makes(year)
    @car_year = year
    uri = URI.parse("https://api.edmunds.com/api/vehicle/v2/makes?state=new&year=#{year}&view=basic&fmt=json&api_key=s65k59axsr9w63js5dbespvw")
    response = Net::HTTP.get_response(uri)
    makes = response.body
    @makes_models_hash = JSON.parse(makes)
    list_makes
  end

  def self.list_makes
    @makes = []
    @makes_models_hash["makes"].each_with_index do |make,index|
      puts "#{index + 1}: #{make["name"]}"
      @makes << make["name"]
    end
    make_select
  end

  def self.make_select
    puts "Enter index # of make"
    make_index = gets.to_i-1
    puts "You selected #{@makes[make_index]}"
    @make_choice = @makes[make_index]
    list_models
  end

  def self.list_models
    @models = []
    @makes_models_hash["makes"].each do |make|
      if make["name"] == @make_choice
        make["models"].each_with_index do |model,index|
          puts "#{index + 1}: #{model["name"]}"
          @models << model["name"]
        end
      end
    end
    model_select
  end

  def self.model_select
    puts "Enter index # of model"
    model_index = gets.to_i-1
    puts "You selected the #{@make_choice} #{@models[model_index]}"
    @model_choice = @models[model_index]
    get_trims
  end

  def self.get_trims
    uri = URI.parse("https://api.edmunds.com/api/vehicle/v2/#{@make_choice.downcase}/#{@model_choice}?state=new&year=#{@car_year}&view=basic&fmt=json&api_key=s65k59axsr9w63js5dbespvw")
    response = Net::HTTP.get_response(uri)
    trims = response.body
    @trims_hash = JSON.parse(trims)
    list_trims
  end

  def self.list_trims
    @trim_ids = {}
    @trims_hash["years"].each do |trim|
      trim["styles"].each_with_index do |sub_trim,index|
        puts "#{index + 1}: #{sub_trim["name"]}"
        @trim_ids[sub_trim["name"]] = sub_trim["id"]
      end
    end
    trim_select
  end

  def self.trim_select
    @final_car_id = ""
    puts "Enter index # of trim"
    trim_index = gets.to_i-1
    puts "You selected the #{@make_choice} #{@model_choice} [#{@trim_ids.keys[trim_index]}]"
    @final_car_id = @trim_ids.values[trim_index]
    get_performance_data
  end

  def self.get_performance_data
    uri = URI.parse("https://api.edmunds.com/api/vehicle/v2/styles/#{@final_car_id}?view=full&fmt=json&api_key=s65k59axsr9w63js5dbespvw")
    response = Net::HTTP.get_response(uri)
    performance = response.body
    @performance_hash = JSON.parse(performance)
    highway_MPG = @performance_hash["MPG"]["highway"]
    puts "MPG Highway: #{@performance_hash["MPG"]["highway"]}"
    city_MPG = @performance_hash["MPG"]["city"]
    puts "MPG City: #{@performance_hash["MPG"]["city"]}"
    combined_MPG = (city_MPG * 0.55) + (highway_MPG * 0.45)
    puts "MPG Combined: #{combined_MPG}"
    puts "Horsepower: #{@performance_hash["engine"]["horsepower"]}"
    puts "Torque: #{@performance_hash["engine"]["torque"]}"
  end

  def self.get_equipment_data
    # https://api.edmunds.com/api/vehicle/v2/styles/' + id + '/equipment?availability=standard&equipmentType=OTHER&fmt=json&api_key=s65k59axsr9w63js5dbespvw
    uri = URI.parse("https://api.edmunds.com/api/vehicle/v2/styles/#{@final_car_id}/equipment?availability=standard&equipmentType=OTHER&fmt=json&api_key=s65k59axsr9w63js5dbespvw")
    response = Net::HTTP.get_response(uri)
    equipment = response.body
    p @equipment_hash = JSON.parse(equipment)

  end
end

puts "Enter a car year:"
year = gets.chomp.to_i
Edmunds.get_makes(year)