class AddColunmRoomToPrices < ActiveRecord::Migration[7.1]
  def change
    add_reference :prices, :room, null: false, foreign_key: true
  end
end
