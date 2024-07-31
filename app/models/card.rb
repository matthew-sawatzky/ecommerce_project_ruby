class Card < ApplicationRecord
  belongs_to :card_set
  belongs_to :item, optional: true

  has_many :items, dependent: :destroy
  has_many :orders, through: :items

  has_one_attached :image

  validates :name, presence: true, uniqueness: true

  scope :search_by_keyword, lambda { |keyword|
    where("title LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%")
  }

  scope :filter_by_category, lambda { |category_id|
    where(card_set_id: category_id) if category_id.present?
  }

  def self.ransackable_attributes(_auth_object = nil)
    # Specify the attributes that should be searchable
    ["name", "rarity", "subtype", "supertype", "created_at", "updated_at", "card_set_id"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["card_set"] # Add associations you want to allow for searching
  end
end
