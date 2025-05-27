class Event < ApplicationRecord
  belongs_to :user
  belongs_to :group
  belongs_to :adventure
  has_many :adventures
  has_many :notifications, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time
  validate :start_time_in_future
  validates :image_url, presence: true
  validates :category, presence: true, inclusion: { in: %w[Food Drinks Music Museums Sports Art Nature] }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, inclusion: { in: %w[Voting_open User_voted Voting_closed Users_attending Cancelled] }

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
