class AddColunmStatusToInn < ActiveRecord::Migration[7.1]
  def change
    add_column :inns, :status, :integer
  end
end
