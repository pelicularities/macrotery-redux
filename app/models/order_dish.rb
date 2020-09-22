class OrderDish < ApplicationRecord
  belongs_to :order
  belongs_to :dish
  validates :quantity, numericality: { greater_than: 0 }
end
