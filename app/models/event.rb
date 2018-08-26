class Event < ApplicationRecord
	belongs_to :user

	def duration
		if start_time.presence && end_time.presence
			TimeDifference.between(start_time, end_time).in_hours
		else
			0
		end
	end
end