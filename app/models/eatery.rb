class Eatery < ApplicationRecord
  validates :name, :address, :phone_number, presence: true, uniqueness: true
  has_many :eatery_cuisines, dependent: :destroy
  has_many :cuisines, through: :eatery_cuisines
  has_many :dishes, dependent: :destroy
end
