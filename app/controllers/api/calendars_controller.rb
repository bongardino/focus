class Api::CalendarsController < ApplicationController
	# private
	require 'google/api_client/client_secrets.rb'
	require 'google/apis/calendar_v3'

  def google_secret
    Google::APIClient::ClientSecrets.new(
      { "web" =>
        { "access_token" => current_user.token,
          "refresh_token" => current_user.refresh_token,
          "client_id" => ENV['GOOGLE_CLIENT_ID'],
          "client_secret" => ENV['GOOGLE_CLIENT_SECRET'],
        }
      }
    )
  end

	def get_events
	  # Initialize Google Calendar API
	  service = Google::Apis::CalendarV3::CalendarService.new
	  # Use google keys to authorize
	  service.authorization = google_secret.to_authorization
	  # Request for a new aceess token just incase it expired
	  service.authorization.refresh!

		calendar_id = 'primary'

		now = Time.now.iso8601
  	one_week = (Time.now + (1*7*24*60*60)).to_datetime.iso8601

		# Fetch the next 10 events for the user
		response = service.list_events(
			calendar_id,
			max_results: nil,
		 	single_events: true,
		 	order_by: 'startTime',
			time_min: Time.now.iso8601,
			time_max: (Time.now + (1*7*24*60*60)).to_datetime.iso8601
			)

		@events = response.items
	end

	def index
		get_events

		Event.destroy_all
		@events.each do |event|
			# binding.pry
			response = "not_found"
			# Event.new(event)

			if event.attendees.presence #break this into its own model. Account for rooms.  Room model? ROOOOOOMMODEL!!!!!!
				event.attendees.each do |attendee|
					if attendee.self
						response = attendee.response_status
					end
					Attendee.find_or_create_by!(email: attendee.email)
				end
			end

			# transition this to Event.find_or_create_by!(uid: "uid") to avoid overwriting data - NTH

			# Move all of this nonsense into an Events method like a grown up


			Event.create!(
				user_id: current_user.id,
				user_uid: User.find_by(id: current_user.id).uid,
				start_time: event.start.date_time,
				end_time: event.end.date_time,
				creator: event.creator.email,
				created: event.created,
				summary: event.summary,
				response: response,
				repeating: event.sequence,
				etag: event.etag,
				url: event.html_link,
				uid: event.id
				)
		end
		@user = current_user
		@all_events = Event.all
		@all_attendees = Attendee.all
		# render 'index.json.jbuilder'
		render 'index.html.erb'
	end

	def show
		@user = current_user
		@all_events = Event.all
		@all_attendees = Attendee.all
		render 'index.html.erb'
	end

end
