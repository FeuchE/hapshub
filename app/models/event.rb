class Event < ApplicationRecord
  belongs_to :user
  belongs_to :group
  belongs_to :adventure, optional: true
  has_many :adventures, dependent: :destroy
  has_many :notifications, dependent: :destroy

  CATEGORIES = %w[food drinks music museums sports art nature].freeze
  # STATUSES = %w[pending voting_open user_voted voting_closed users_attending cancelled].freeze

  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time
  validate :start_time_in_future
  validates :category, presence: true, inclusion: { in: CATEGORIES }

  after_create :generate_adventures

  # Scope for upcoming events
  scope :upcoming, -> { where('start_time >= ?', Time.current).order(start_time: :asc) }

  def generate_adventures
    client = Google::Apis::PlacesV1::MapsPlacesService.new
    client.key = ENV["GOOGLE_API_KEY"]

    request = Google::Apis::PlacesV1::GoogleMapsPlacesV1SearchTextRequest.new(
      text_query: "#{category} in #{location}"
    )

    begin
      results = client.search_place_text(
        request,
        fields: "places.id,places.display_name.text,places.formatted_address,places.price_level,places.photos.name"
      )
    rescue Google::Apis::ClientError => e
      Rails.logger.error("Google Places API error: #{e.message}")
      return
    end

    results.places.each do |result|
      display_name = result.display_name.respond_to?(:text) ? result.display_name.text : result.display_name
      photo = result.photos&.first&.name

      adventures.create!(
        name: display_name,
        location: result.formatted_address,
        photo_resource: photo,
        description: "Suggested by Google Places",
        place_id: result.id
      )
    end
  end

  def photo_url
    image_url.presence || "https://via.placeholder.com/180x120"
  end

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
