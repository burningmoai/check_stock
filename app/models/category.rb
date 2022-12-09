class Category < ApplicationRecord
  has_many :foods, dependent: :destroy
  validates :name, uniqueness: true, presence: true
end
