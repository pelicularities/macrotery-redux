class OrderDish < ApplicationRecord
  belongs_to :order
  belongs_to :dish
  has_one :review, dependent: :destroy
  validates :quantity, numericality: { greater_than: 0 }
end
