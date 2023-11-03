class AddColunmToInn < ActiveRecord::Migration[7.1]
  def change
    add_column :inns, :check_in, :string
    add_column :inns, :check_out, :string
  end
end
