json.array! @events, partial: 'event', as: :event

# json.array! @events.each do |event|
# 	json.summary event.summary
# 	json.start_time event.start_time
# 	json.end_time event.end_time
# 	json.duration event.duration
# 	json.creator event.creator
# 	json.created event.created
# 	json.response event.response
# 	json.repeating event.repeating
# 	json.etag event.etag
# 	json.url event.url
# 	json.uid event.uid
# 	json.user_id event.user_id
# 	json.user_uid event.user_uid
	
# 	event.attendees.each do |attendee|
# 		json.attendee attendee.email
# 	end
# end