class Card < ApplicationRecord
  belongs_to :card_set
  belongs_to :item, optional: true

  has_many :items
  has_many :orders, through: :items

  has_one_attached :image

  validates :name, presence: true, uniqueness: true

  scope :search_by_keyword, -> (keyword) {
    where('title LIKE ? OR description LIKE ?', "%#{keyword}%", "%#{keyword}%")
  }

  scope :filter_by_category, -> (category_id) {
    where(card_set_id: category_id) if category_id.present?
  }

    def self.ransackable_attributes(auth_object = nil)
    # Specify the attributes that should be searchable
    ["name", "rarity", "subtype", "supertype", "created_at", "updated_at", "card_set_id"]
  end
  def self.ransackable_associations(auth_object = nil)
  ["card_set"] # Add associations you want to allow for searching
end

end
