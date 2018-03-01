class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :state
      t.string :city
      t.string :zip_code
      t.text :address
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
