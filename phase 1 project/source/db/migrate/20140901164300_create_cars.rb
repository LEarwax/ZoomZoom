class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer   :horsepower
      t.integer   :torque
      t.integer   :mpg
      t.integer   :Zero2Sixty
      t.integer   :turn_radius
      t.integer   :air_drag
      t.integer   :weight

      t.timestamps
    end
  end
end
