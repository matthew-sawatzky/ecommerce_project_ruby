# app/models/card_set.rb
class CardSet < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :series, presence: true
  has_many :cards, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "id", "id_value", "name", "series", "updated_at"]
  end
end
