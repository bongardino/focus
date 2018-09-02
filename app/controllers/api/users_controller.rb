class Api::UsersController < ApplicationController

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

	def index
		@users = User.all
		# render json: { current_user: "#{current_user.id}" }
		render 'index.json.jbuilder'
	end

	def show
		auth
		p current_user
		# user_id = params[:id]
		@user = User.find(current_user.id)
		render 'show.json.jbuilder'
	end
end
