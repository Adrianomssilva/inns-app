class AddColunmStatusToRaservation < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :status, :integer, default: 0
  end
end
