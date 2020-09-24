class AddCaloriesToMacros < ActiveRecord::Migration[6.0]
  def change
    add_column :macros, :calories, :integer
  end
end
