class Card < ApplicationRecord
  belongs_to :set
  belongs_to :item

  has_many :items
  has_many :orders, through: :items
end
