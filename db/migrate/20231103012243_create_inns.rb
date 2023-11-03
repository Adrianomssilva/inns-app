class CreateInns < ActiveRecord::Migration[7.1]
  def change
    create_table :inns do |t|
      t.string :brand_name
      t.string :corporate_name
      t.string :registration_number
      t.string :phone
      t.string :email
      t.string :address
      t.string :neighborhood
      t.string :state
      t.string :city
      t.string :cep
      t.references :owner, null: false, foreign_key: true
      t.text :description
      t.string :paymente_options
      t.string :pets
      t.text :policies

      t.timestamps
    end
  end
end
