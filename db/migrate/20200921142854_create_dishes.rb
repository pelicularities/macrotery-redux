class CreateDishes < ActiveRecord::Migration[6.0]
  def change
    create_table :dishes do |t|
      t.references :eatery, null: false, foreign_key: true
      t.string :name
      t.decimal :price
      t.integer :protein
      t.carbs :
      t.integer :fats
      t.text :description

      t.timestamps
    end
  end
end
