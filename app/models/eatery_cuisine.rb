class EateryCuisine < ApplicationRecord
  belongs_to :eatery
  belongs_to :cuisine
  validates :cuisine, uniqueness: { scope: :eatery }
end
