class Api::CalendarController < ApplicationController
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

	def get_calendars
	  # Initialize Google Calendar API
	  service = Google::Apis::CalendarV3::CalendarService.new
	  # Use google keys to authorize
	  service.authorization = google_secret.to_authorization
	  # Request for a new aceess token just incase it expired
	  service.authorization.refresh!
	  # Get a list of calendars
		calendar_id = 'primary'
		response = service.list_events(calendar_id,
		                               max_results: 10,
		                               single_events: true,
		                               order_by: 'startTime',
		                               time_min: Time.now.iso8601)
		@reponse = response
		render 'index.html.erb'
	end
end
