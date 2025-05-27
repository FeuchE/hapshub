class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :message, presence: true
  validates :attending, inclusion: { in: [true, false] }
end
