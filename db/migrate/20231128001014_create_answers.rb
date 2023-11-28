class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.references :avaliation, null: false, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end
