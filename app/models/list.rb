class List < ApplicationRecord
  belongs_to :food
  belongs_to :user
  has_many :stocks #dependent: :destroy お買いものリストから削除したときストックが消えるわけではない
  validates :amount, presence: true
end
