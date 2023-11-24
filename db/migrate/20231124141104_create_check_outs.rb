class CreateCheckOuts < ActiveRecord::Migration[7.1]
  def change
    create_table :check_outs do |t|
      t.datetime :exit
      t.references :reservation, null: false, foreign_key: true
      t.integer :total

      t.timestamps
    end
  end
end
