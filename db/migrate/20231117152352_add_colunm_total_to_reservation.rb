class AddColunmTotalToReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :total_value, :integer
  end
end
