class AddColumnToRooms < ActiveRecord::Migration[7.1]
  def change
    add_reference :rooms, :inn, null: false, foreign_key: true
  end
end
