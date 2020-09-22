class ChangeEateries < ActiveRecord::Migration[6.0]
  def change
    change_column :eateries, :lat, :float
    change_column :eateries, :long, :float
  end
end
