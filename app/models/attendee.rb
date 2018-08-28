class Attendee < ApplicationRecord
	has_many :attendee_events
	has_many :events, through: :attendee_events
end
