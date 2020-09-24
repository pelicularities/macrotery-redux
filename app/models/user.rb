class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :macros, dependent: :destroy
  has_many :orders, dependent: :destroy
  validates :first_name, :last_name, presence: true
  after_find :calculate_calories, if: :calories_empty?

  private

  def calculate_calories
    unless self.protein.nil? || self.carbs.nil? || self.fats.nil?
      self.calories = self.protein * 4 + self.carbs * 4 + self.fats * 9
    end
  end

  def calories_empty?
    self.calories.nil?
  end
end
