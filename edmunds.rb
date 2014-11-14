require 'net/http'
require 'json'

module View
  def self.clear_screen
    print "\e[2J"
    print "\e[H"
  end
end

module Edmunds

  def self.run(year)
    @car_info_hash = {}
    @car_year = year
    if @car_year.between?(2014, 2015)
      get_new_makes
    elsif @car_year.between?(1970, 2013)
      get_used_makes
    else
      puts "Invalid car year!"
    end
  end

  def self.get_new_makes
    uri = URI.parse("https://api.edmunds.com/api/vehicle/v2/makes?state=new&year=#{@car_year}&view=basic&fmt=json&api_key=s65k59axsr9w63js5dbespvw")
    response = Net::HTTP.get_response(uri)
    makes = response.body
    @makes_models_hash = JSON.parse(makes)
    @car_info_hash[:year] = @car_year
    list_makes
  end

  def self.get_used_makes
    uri = URI.parse("https://api.edmunds.com/api/vehicle/v2/makes?state=used&year=#{@car_year}&view=basic&fmt=json&api_key=s65k59axsr9w63js5dbespvw")
    response = Net::HTTP.get_response(uri)
    makes = response.body
    @makes_models_hash = JSON.parse(makes)
    @car_info_hash[:year] = @car_year
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
    @car_info_hash[:make] = @make_choice
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
    @car_info_hash[:model] = @model_choice
    if @car_year.between?(2014, 2015)
      get_new_trims
    elsif @car_year.between?(1970, 2013)
      get_used_trims
    end
  end

  def self.get_new_trims
    uri = URI.parse("https://api.edmunds.com/api/vehicle/v2/#{@make_choice.gsub(/\s+/, "").downcase}/#{@model_choice.gsub(/\s+/, "").downcase}?state=new&year=#{@car_year}&view=basic&fmt=json&api_key=s65k59axsr9w63js5dbespvw")
    response = Net::HTTP.get_response(uri)
    trims = response.body
    @trims_hash = JSON.parse(trims)
    list_trims
  end

  def self.get_used_trims
    uri = URI.parse("https://api.edmunds.com/api/vehicle/v2/#{@make_choice.gsub(/\s+/, "").downcase}/#{@model_choice.gsub(/\s+/, "").downcase}?state=used&year=#{@car_year}&view=basic&fmt=json&api_key=s65k59axsr9w63js5dbespvw")
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
    @car_info_hash[:trim] = @trim_ids.keys[trim_index]
    @final_car_id = @trim_ids.values[trim_index]
    @car_info_hash[:edmundsID] = @final_car_id
    get_performance_data
  end

  def self.get_performance_data
    uri = URI.parse("https://api.edmunds.com/api/vehicle/v2/styles/#{@final_car_id}?view=full&fmt=json&api_key=s65k59axsr9w63js5dbespvw")
    response = Net::HTTP.get_response(uri)
    performance = response.body
    @performance_hash = JSON.parse(performance)
    # highway_MPG = @performance_hash["MPG"]["highway"]
    # city_MPG = @performance_hash["MPG"]["city"]
    @car_info_hash[:horsepower] = @performance_hash["engine"]["horsepower"]
    @car_info_hash[:torque] = @performance_hash["engine"]["torque"]
    get_equipment_data
  end

  def self.get_equipment_data
    uri = URI.parse("https://api.edmunds.com/api/vehicle/v2/styles/#{@final_car_id}/equipment?availability=standard&equipmentType=OTHER&fmt=json&api_key=s65k59axsr9w63js5dbespvw")
    response = Net::HTTP.get_response(uri)
    equipment = response.body
    @equipment_hash = JSON.parse(equipment)
    sort_equipment_data
  end

  def self.sort_equipment_data
    @equipment_hash['equipment'].each do |equip|
      if equip['name'] == 'Specifications'
        equip['attributes'].each do |spec|
          if spec['name'] == 'Curb Weight'
            @car_info_hash[:weight] = spec['value']
          elsif spec['name'] == 'Manufacturer 0 60mph Acceleration Time (seconds)'
            @car_info_hash[:zero_2_sixty] = spec['value']
          elsif spec['name'] == 'Epa Combined Mpg'
            @car_info_hash[:mpg_combined] = spec['value']
          end
        end
      end
    end
    final_hash
  end

  def self.final_hash
    return @car_info_hash
  end
end

puts "Enter a car year:"
year = gets.chomp.to_i
Edmunds.run(year)