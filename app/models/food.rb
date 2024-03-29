class Food < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :lists, dependent: :destroy
  belongs_to :user
  belongs_to :category

  validates :name, presence: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  scope :latest, -> {order(created_at: :asc)}
end
