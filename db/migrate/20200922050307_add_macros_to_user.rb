class AddMacrosToUser < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.integer :protein
      t.integer :carbs
      t.integer :fats
    end
  end
end
