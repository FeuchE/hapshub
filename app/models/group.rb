class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups

  has_many :events, dependent: :destroy  # Add this line

  validates :name, presence: true, uniqueness: true
end
