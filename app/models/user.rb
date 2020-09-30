class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :macros, dependent: :destroy
  has_many :orders, dependent: :destroy
  validates :first_name, :last_name, presence: true
  after_find :calculate_calories, if: :calories_empty?

  def default_macro
    default = self.macros.find_by default: true
    if default.nil?
      default = self.macros.first
    end
    default
  end


  def change_default(new_default)
    # check if new default is already default
    # if yes, do nothing
    # check if new default macros belongs to current user?
    # if no, do nothing.
    # else all user macros need to be changed to default: false
    # get new default and set it to true
    # save
    unless self.default_macro == new_default && self.macros.include?(new_default)
      self.macros.each do |macro|
        macro.default = false
        macro.save!
      end
      new_default.default = true
      new_default.save ? true : false
    end
  end

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
