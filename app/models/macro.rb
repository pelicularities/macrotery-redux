class Macro < ApplicationRecord
  belongs_to :user
  validates :name, :protein, :carbs, :fats, presence: true
  validates :name, uniqueness: { scope: :user, message: 'User already has a meal by this name' }

  validates :protein, :carbs, :fats, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 200}
  after_create :calculate_calories
  after_find :calculate_calories, if: :calories_empty?

  def calories
    self.protein * 4 + self.carbs * 4 + self.fats * 9
  end
  
  private

  def calculate_calories
    self.calories = self.protein * 4 + self.carbs * 4 + self.fats * 9
  end

  def calories_empty?
    self.calories.nil?
  end
end
