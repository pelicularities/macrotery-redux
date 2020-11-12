class AddSessionToOrderAgain < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :checkout_session_id, :string
    add_column :orders, :state, :string, default: "pending"
  end
end
