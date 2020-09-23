class Macro < ApplicationRecord
  belongs_to :user
  validates :name, :protein, :carbs, :fats, presence: true
  validates :name, uniqueness: { scope: :user, message: 'User already has a meal by this name' }
  after_find :calculate_calories, if: :calories_empty?

  private

  def calculate_calories
    self.calories = self.protein * 4 + self.carbs * 4 + self.fats * 9
  end

  def calories_empty?
    self.calories.nil?
  end
end
