class CreateCars < ActiveRecord::Migration
  def change

    create_table :cars do |t|
      t.belongs_to :driver
      t.integer    :year
      t.integer    :make
      t.integer    :model
      t.integer    :trim
      t.integer    :mpg_combined
      t.integer    :horsepower
      t.integer    :torque
      t.integer    :airdrag
      t.integer    :weight
      t.integer    :zero_2_sixty
      t.integer    :edmundsID

      t.timestamps
    end
  end
end
