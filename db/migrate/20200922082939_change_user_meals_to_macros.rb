class ChangeUserMealsToMacros < ActiveRecord::Migration[6.0]
  def change
    rename_table(:user_meals, :macros)
  end
end
