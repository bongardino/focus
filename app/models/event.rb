class Event < ApplicationRecord
	has_many :attendee_events
  has_many :attendees, through: :attendee_events

	def duration
		if start_time.presence && end_time.presence
			TimeDifference.between(start_time, end_time).in_hours
		else
			0
		end
	end
end