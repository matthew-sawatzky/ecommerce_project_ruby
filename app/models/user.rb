class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
      
  belongs_to :province
  validates :password, presence: true, length: { minimum: 8 }
  validates :username, presence: true, uniqueness: true

  def admin?
    admin
  end
end


