class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :notifications, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups
  has many :votes, dependent: :destroy
  has_many :adventures, through: :votes

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
