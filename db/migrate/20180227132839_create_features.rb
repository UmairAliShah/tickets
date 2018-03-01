class CreateFeatures < ActiveRecord::Migration[5.1]
  def change
    create_table :features do |t|
      t.string :title
      t.string :content1
      t.string :content2
      t.string :content3
      t.string :content4
      t.string :content5
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
