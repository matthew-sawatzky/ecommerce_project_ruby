class StaticPage < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["title", "content", "created_at", "updated_at"]
  end
end
