class Dish < ApplicationRecord
  belongs_to :eatery
  has_many :order_dishes, dependent: :destroy
  has_many :reviews, through: :order_dishes
  validates :name, :price, :protein, :carbs, :fats, presence: true
  validates :name, uniqueness: { scope: :eatery, message: 'eatery already has a dish by this name' }
end
