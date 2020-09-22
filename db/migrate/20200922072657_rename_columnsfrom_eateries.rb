class RenameColumnsfromEateries < ActiveRecord::Migration[6.0]
  def change
    change_table :eateries do |t|
      t.rename :lat, :latitude
      t.rename :long, :longitude
    end
  end
end
