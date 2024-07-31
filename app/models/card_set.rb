# app/models/card_set.rb
class CardSet < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :series, presence: true
  has_many :cards

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "series", "updated_at"]
  end
end
