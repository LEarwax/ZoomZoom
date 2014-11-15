class CreateCars < ActiveRecord::Migration
  def change

    create_table :cars do |t|
      t.integer    :year
      t.string    :make
      t.string    :model
      t.string    :trim
      t.integer    :mpg_combined
      t.integer    :horsepower
      t.integer    :torque
      t.integer    :weight
      t.integer    :zero_2_sixty
      t.integer    :edmundsID

      t.timestamps
    end
  end
end
