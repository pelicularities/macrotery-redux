class UserMeal < ApplicationRecord
  belongs_to :user
  validates :name, :protein, :carbs, :fats, presence: true
  validates :name, uniqueness: true
end
