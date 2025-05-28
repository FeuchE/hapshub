class Adventure < ApplicationRecord
  belongs_to :event, optional: true
  has_many :events
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :location, presence: true
  validates :image_url, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description_and_location,
    against: [
      :name,
      :description,
      :location
    ],
    using: {
      tsearch: { prefix: true }
    }
end
