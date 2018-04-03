class Place < ApplicationRecord
	has_many :events
	validates :name, length: {minimum: 20}
  validates :capacity, numericality: { only_integer: true, greater_than_or_equal_to: 0}
end
