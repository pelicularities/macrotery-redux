class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :dine_in
      t.datetime :preferred_time
      t.boolean :confirmed

      t.timestamps
    end
  end
end
