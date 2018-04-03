class Ticket < ApplicationRecord
  belongs_to :event
  has_many :user_tickets
  has_many :users, through: :user_tickets
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validate :ticket_cannot_be_created_after_start_date

  # The ticket itself cannot be created after the start date of the associated event.
  def ticket_cannot_be_created_after_start_date
    event_start_date = self.event.start_date
    if Date.today >  event_start_date
      errors.add(:created_at, "ticket cannot be created after start date of event" )
    end
  end
end
