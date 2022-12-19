class Category < ApplicationRecord
  has_many :foods, dependent: :destroy
  has_many :stocks
  validates :name, uniqueness: true, presence: true
end
