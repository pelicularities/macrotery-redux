class AddCaloriesToDishes < ActiveRecord::Migration[6.0]
  def change
    add_column :dishes, :calories, :integer
  end
end
