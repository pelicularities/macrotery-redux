class CreateUserMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :user_meals do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :protein
      t.integer :carbs
      t.integer :fats
      t.string :name

      t.timestamps
    end
  end
end
