class CreateEateries < ActiveRecord::Migration[6.0]
  def change
    create_table :eateries do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.decimal :lat
      t.decimal :long
      t.text :description

      t.timestamps
    end
  end
end
