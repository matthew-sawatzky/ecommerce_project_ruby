# app/models/card_set.rb
class CardSet < ApplicationRecord
  validates :set_name, presence: true, uniqueness: true
  validates :set_series, presence: true
end
