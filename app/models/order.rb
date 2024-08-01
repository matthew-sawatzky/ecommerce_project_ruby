class Order < ApplicationRecord
  belongs_to :user

  has_many :items, dependent: :destroy
  has_many :cards, through: :items

  validates :order_total, presence: true, 
  numericality: { greater_than_or_equal_to: 0 }

  def tax_details
    province = user.province
    {
    provincial_tax: province.provincial_tax,
    federal_tax: province.federal_tax,
    tax_type: province.tax_type,
    }
  end

  # Method to calculate total tax
  def total_tax
    tax = tax_details
    (order_total * (tax[:provincial_tax] + tax[:federal_tax]) / 100.0).round(2)
  end
end
