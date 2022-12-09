class List < ApplicationRecord
  belongs_to :food
  belongs_to :user
  validates :amount, presence: true
end
