class ChangeOrderDefaults < ActiveRecord::Migration[6.0]
  def change
    change_column_default :orders, :confirmed, false
  end
end
