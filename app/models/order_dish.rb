class OrderDish < ApplicationRecord
  belongs_to :order
  belongs_to :dish
  belongs_to :user, through: :order
  validates :quantity, numericality: { greater_than: 0 }
end
