class RemoveStatusFromInn < ActiveRecord::Migration[7.1]
  def change
    remove_column :inns, :status, :integer
  end
end
