# app/models/card_set.rb
class CardSet < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :series, presence: true
  has_many :cards
end
