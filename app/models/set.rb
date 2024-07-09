class Set < ApplicationRecord
    has_many :cards

    has_many :cards, foreign_key: 'set_id', primary_key: 'api_id'
end
