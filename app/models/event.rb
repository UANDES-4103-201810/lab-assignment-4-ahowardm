class Event < ApplicationRecord
  belongs_to :place
  has_many :tickets
  validate :start_date_must_be_later_than_date_of_creation, :no_other_event_in_the_same_venue_with_same_start_date

  # start date: must be later than current date of creation
  def start_date_must_be_later_than_date_of_creation
    if start_date < Date.today
      errors.add(:start_date, "start date must be later than date of creation")
    end
  end

  # There must not exist other event hosted in the same venue with the same start date
  def no_other_event_in_the_same_venue_with_same_start_date
    other_events_same_venue = Event.where(place: self.place)
    other_events_same_venue.each do |event|
      if start_date == event.start_date
        errors.add(:start_date, "there is another event in the same venue the same day")
      end
    end
  end
end
