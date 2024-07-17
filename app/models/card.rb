class Card < ApplicationRecord
  belongs_to :card_set, foreign_key: 'set_id'
  belongs_to :item, optional: true

  has_many :items
  has_many :orders, through: :items

  validates :card_name, presence: true, uniqueness: true
end
