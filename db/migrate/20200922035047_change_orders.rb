class ChangeOrders < ActiveRecord::Migration[6.0]
  def change
    change_column_default :orders, :dine_in, to: true
    change_column_default :orders, :confirmed, to: false
  end
end
