class Eatery < ApplicationRecord
  validates :name, :address, :phone_number, presence: true
  has_many :eatery_cuisines, dependent: :destroy
  has_many :cuisines, through: :eatery_cuisines
  has_many :dishes, dependent: :destroy
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
