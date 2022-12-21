class Category < ApplicationRecord
  has_many :foods, dependent: :destroy
  has_many :stocks
  belongs_to :user
  validates :name, uniqueness: true, presence: true
end
