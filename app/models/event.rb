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

	def responses
		attendees = []
		attendee_events.each do |attendee|
			email = Attendee.find(attendee.attendee_id).email
			status = attendee.status
			attendees << { email => status }
		end
		attendees
	end

	def one_to_one?
		attendees.count == 2 || attendees.count == 3 
	end
end