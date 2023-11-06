class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :description
      t.integer :capacity
      t.integer :default_price
      t.string :bathroom
      t.string :balcony
      t.string :air_conditioning
      t.string :tv
      t.string :wardrobe
      t.string :safe
      t.string :pcd
      t.string :dimension

      t.timestamps
    end
  end
end
