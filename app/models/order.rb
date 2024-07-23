class Order < ApplicationRecord
  belongs_to :user

  has_many :items, dependent: :destroy
  has_many :cards, through: :items

  validates :order_total, presence: true
end
