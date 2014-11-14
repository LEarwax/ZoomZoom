

10.times do
  Car.create ({year: rand(1959..2000),
              make: Faker::Company.name,
              model: Faker::Name.first_name,
              trim: "4-dr, 4 cylinder",
              mpg_combined: rand(10..50),
              horsepower: rand(200..400),
              torque: rand(50..900),
              airdrag: "shitty",
              weight: "2 tons",
              zero_2_sixty: "4 seconds",
              edmunds_identification: rand(10..90)})
end


4.times do
  Driver.create ({name: Faker::Name.first_name})
end


