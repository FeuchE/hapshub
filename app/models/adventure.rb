class Adventure < ApplicationRecord
  belongs_to :event, optional: true
  has_many :events, dependent: :nullify
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true
  #validates :image_url, presence: true

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
    def google_image
       client = Google::Apis::PlacesV1::MapsPlacesService.new
        client.key = ENV["GOOGLE_API_KEY"]
        uri = URI("https://places.googleapis.com/v1/places:searchText?key=#{client.key}")
      client.get_place_photo_media(photo_resource + "/media")
    end
end
