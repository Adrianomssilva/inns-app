class CreateCheckIns < ActiveRecord::Migration[7.1]
  def change
    create_table :check_ins do |t|

      t.timestamps
    end
  end
end
