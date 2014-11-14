class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.belongs_to :car
      t.belongs_to :driver
      t.timestamps
    end
  end
end
