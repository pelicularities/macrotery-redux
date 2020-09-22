class Review < ApplicationRecord
  belongs_to :order_dish
  validates :rating, presence: true
  validates :rating, numericality: { greater_than: -1, less_than: 6 }
end
