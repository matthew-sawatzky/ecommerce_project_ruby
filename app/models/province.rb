class Province < ApplicationRecord
  has_many :users

  validates :province_name, presence: true, uniqueness: true
  validates :tax_type, presence: true

  # Optional: Validation for specific tax types
  validates :tax_type,
            inclusion: { in: %w[pst hst gst qst], message: "%<value>s is not a valid tax type" }
end
