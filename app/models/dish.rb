class Dish < ApplicationRecord
  belongs_to :eatery
  has_many :order_dishes, dependent: :destroy
  has_many :reviews, through: :order_dishes
  has_one_attached :photo
  validates :name, :price, :protein, :carbs, :fats, presence: true
  validates :name, uniqueness: { scope: :eatery, message: 'eatery already has a dish by this name' }
  after_find :calculate_calories, if: :calories_empty?

  private

  def calculate_calories
    self.calories = self.protein * 4 + self.carbs * 4 + self.fats * 9
  end

  def calories_empty?
    self.calories.nil?
  end
end
