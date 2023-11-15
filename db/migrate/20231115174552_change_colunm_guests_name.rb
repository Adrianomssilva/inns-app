class ChangeColunmGuestsName < ActiveRecord::Migration[7.1]
  def change
    rename_column :reservations, :guests, :guest_number
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
