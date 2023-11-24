class AddColunmToCheckOut < ActiveRecord::Migration[7.1]
  def change
    add_column :check_outs, :payment_method, :string
  end
end
