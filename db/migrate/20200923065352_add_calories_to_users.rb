class AddCaloriesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :calories, :integer
  end
end
