class Card < ApplicationRecord
  belongs_to :set
  belongs_to :item
  belongs_to :set, foreign_key: 'set_id', primary_key: 'api_id'

  has_many :items
  has_many :orders, through: :items
  
end
