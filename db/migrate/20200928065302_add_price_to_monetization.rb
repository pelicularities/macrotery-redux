class AddPriceToMonetization < ActiveRecord::Migration[6.0]
  def change
    add_monetize :dishes, :price, currency: { present: false }
  end
end
