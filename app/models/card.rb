class Card < ApplicationRecord
  belongs_to :card_set
  belongs_to :item, optional: true

  has_many :items
  has_many :orders, through: :items

  has_one_attached :image

  validates :name, presence: true, uniqueness: true
end
