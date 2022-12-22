class Category < ApplicationRecord
  has_many :foods, dependent: :destroy
  has_many :stocks
  belongs_to :user
  validates :name, presence: true
end
