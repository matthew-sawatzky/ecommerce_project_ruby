class Item < ApplicationRecord
  belongs_to :card
  belongs_to :order
end
