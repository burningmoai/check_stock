class Stock < ApplicationRecord
  belongs_to :food
  belongs_to :user
  belongs_to :category

  validates :amount, presence: true
  validates :limit, presence: true

  enum unit: { ko: 0, hon: 1, fukuro: 2, tama: 3, mai: 4 }

  def quantity
    amount.to_s + unit
  end
end
