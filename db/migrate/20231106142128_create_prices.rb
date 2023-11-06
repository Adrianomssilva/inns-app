class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.string :values
      t.date :date_start
      t.date :date_end

      t.timestamps
    end
  end
end
