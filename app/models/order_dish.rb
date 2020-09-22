class OrderDish < ApplicationRecord
  belongs_to :order
  belongs_to :dish
  belongs_to :user, through: :order
  has_one :review, dependent: :destroy
  validates :quantity, numericality: { greater_than: 0 }
end
