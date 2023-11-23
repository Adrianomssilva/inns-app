class ChangeCheckinAndCheckoutTypesFromInn < ActiveRecord::Migration[7.1]
  def change
    change_column :inns, :check_in, :time
    change_column :inns, :check_out, :time
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
