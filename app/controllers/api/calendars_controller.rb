class Api::CalendarsController < ApplicationController
	# private
	require 'google/api_client/client_secrets.rb'
	require 'google/apis/calendar_v3'

  def google_secret
    Google::APIClient::ClientSecrets.new(
      { "web" =>
        { "access_token" => current_user.token,											# notitfy if user not logged in
          "refresh_token" => current_user.refresh_token,
          "client_id" => ENV['GOOGLE_CLIENT_ID'],
          "client_secret" => ENV['GOOGLE_CLIENT_SECRET'],
        }
      }
    )
  end

	def auth
	  # Initialize Google Calendar API
	  service = Google::Apis::CalendarV3::CalendarService.new
	  # Use google keys to authorize
	  service.authorization = google_secret.to_authorization
	  # Request for a new aceess token just incase it expired
	  service.authorization.refresh!
	end

	def get_events
	  # Initialize Google Calendar API
	  service = Google::Apis::CalendarV3::CalendarService.new
	  # Use google keys to authorize
	  service.authorization = google_secret.to_authorization
	  # Request for a new aceess token just incase it expired
	  service.authorization.refresh!

		calendar_id = 'primary'

		today = Date.today # Today's date
		week_start = today.at_beginning_of_week.to_datetime.iso8601
		week_end = today.at_end_of_week.to_datetime.iso8601
		month_start = today.at_beginning_of_month.to_datetime.iso8601
		month_end = today.at_end_of_month.to_datetime.iso8601
		# now = Time.now.iso8601

		response = service.list_events(
			calendar_id,
			max_results: nil,
		 	single_events: true,
		 	order_by: 'startTime',
			time_min: week_start,
			time_max: week_end
			)

		response.items
	end

	def build
		json_success = []
		get_events.each do |event|
			if !Event.find_by(uid: event.id).nil?																		# replace this with find or create by, to update existing events instead of skipping them entirely
				new_event = Event.find_by(uid: event.id)
			else
				new_event = Event.new(
					start_time: event.start.date_time,																	# extract nested loops to methods, evaluate the decision tree
					end_time: event.end.date_time,
					creator: event.creator.email,
					created: event.created,
					summary: event.summary,
					repeating: event.sequence,
					etag: event.etag,
					url: event.html_link,
					uid: event.id,
					user_id: current_user.id,
					user_uid: current_user.uid
					)
			end

			if new_event.valid?																											# loop through attendees
				new_event.save
				if !event.attendees.nil?
					event.attendees.each do |attendee|
						new_attendee = Attendee.find_or_create_by(email: attendee.email)	# create attendee
						if new_attendee.valid?																						# create attendeeEvents relationship
							new_attendee_event = AttendeeEvent.new(
														attendee_id: new_attendee.id,
														event_id: new_event.id,
														status: attendee.response_status
														)
							if new_attendee_event.save
								json_success << { success: "#{new_attendee.email} was attatched to attendee event id of #{new_attendee_event.id}" }
							else
								json_success << { error: "#{new_attendee_event.errors.full_messages}" }
							end
						end
					end
				end
			end
		end
		# render json: { message: json_success }
		# redirect_to action: "show"
	end

	def index
		build
		@user = current_user
		@events = Event.where("user_id = ?", current_user.id)
		@attendees = Attendee.all
		# render 'index.html.erb'
		render 'index.json.jbuilder'
	end

	def show
		auth
		@user = current_user
		@events = Event.all
		@attendees = Attendee.all
		# render 'index.html.erb'
		render 'index.json.jbuilder'
	end

end
