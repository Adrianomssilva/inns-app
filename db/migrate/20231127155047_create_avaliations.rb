class CreateAvaliations < ActiveRecord::Migration[7.1]
  def change
    create_table :avaliations do |t|
      t.integer :rate
      t.references :reservation, null: false, foreign_key: true
      t.references :inn, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end
