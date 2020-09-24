class Order < ApplicationRecord
  belongs_to :user
  has_many :order_dishes, dependent: :destroy
  has_many :dishes, through: :order_dishes
  has_many :reviews, through: :order_dishes

  accepts_nested_attributes_for :order_dishes
end
