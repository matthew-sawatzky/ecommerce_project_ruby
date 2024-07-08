class Order < ApplicationRecord
  belongs_to :user
  
  has_many :items
  has_many :cards, through: :items
end
