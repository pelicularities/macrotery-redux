class Order < ApplicationRecord
  belongs_to :user
  has_many :order_dishes, dependent: :destroy
  has_many :dishes, through: :order_dishes
  has_many :reviews, through: :order_dishes

  monetize :amount_cents

  accepts_nested_attributes_for :order_dishes

  def eatery
    self.order_dishes.first.dish.eatery
  end
end
