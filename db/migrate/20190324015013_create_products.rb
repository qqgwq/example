class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :category_id
      t.string :image
      t.decimal :price

      t.timestamps
    end
  end
end
