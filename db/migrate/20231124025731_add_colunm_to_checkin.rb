class AddColunmToCheckin < ActiveRecord::Migration[7.1]
  def change
    add_reference :check_ins, :reservation, null: false, foreign_key: true
    add_column :check_ins, :entry, :datetime
  end
end
