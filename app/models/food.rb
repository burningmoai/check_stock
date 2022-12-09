class Food < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :lists, dependent: :destroy
  belongs_to :user
  belongs_to :category

  validates :name, uniqueness: true, presence: true

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
