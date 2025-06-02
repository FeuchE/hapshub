class Event < ApplicationRecord
  belongs_to :user
  belongs_to :group
  belongs_to :adventure, optional: true
  has_many :adventures, dependent: :destroy
  has_many :notifications, dependent: :destroy
  CATEGORIES = %w[food drinks music museums sports art nature].freeze
  # STATUSES = %w[pending voting_open user_voted voting_closed users_attending cancelled].freeze

  # validates :name, presence: true, uniqueness: true
  # validates :description, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time
  validate :start_time_in_future
  # validates :image_url, presence: true
  validates :category, presence: true, inclusion: { in: %w[food drinks music museums sports art nature] }
  # validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # validates :status, presence: true, inclusion:
  #   { in: %w[pending voting_open user_voted voting_closed users_attending cancelled] }

  def generate_adventures

    client = Google::Apis::PlacesV1::MapsPlacesService.new
    client.key = ENV["GOOGLE_API_KEY"]
    results = client.search_place_text(Google::Apis::PlacesV1::GoogleMapsPlacesV1SearchTextRequest.new(text_query: "Spicy Vegetarian Food in Sydney, Australia"), fields: "places.displayName,places.formattedAddress,places.priceLevel" )

  private

  def end_time_after_start_time
    if end_time.present? && start_time.present? && end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end

  def start_time_in_future
    if start_time.present? && start_time < Time.current
      errors.add(:start_time, "must be in the future")
    end
  end
end
