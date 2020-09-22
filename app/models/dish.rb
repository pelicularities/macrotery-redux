class Dish < ApplicationRecord
  belongs_to :eatery
  validates :name, :price, :protein, :carbs, :fats, presence: true
  validates :name, uniqueness: { scope: :eatery, message: 'eatery already has a dish by this name' }
end
