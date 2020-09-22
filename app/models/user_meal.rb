class UserMeal < ApplicationRecord
  belongs_to :user
  validates :name, :protein, :carbs, :fats, presence: true
  validates :name, uniqueness: { scope: :user, message: 'User already has a meal by this name' }
end
