class Cuisine < ApplicationRecord
  validates :name, presence: true
  has_many :eatery_cuisines
  has_many :eateries, through: :eatery_cuisines
end
