class Stock < ApplicationRecord
  belongs_to :food
  belongs_to :user
  
  validates :amount, presence: true
  validates :limit, presence: true
end
