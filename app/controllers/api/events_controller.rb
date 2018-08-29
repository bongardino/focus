class Api::EventsController < ApplicationController
	def index
		p current_user
		user = User.find(current_user.id)

		@events = user.events
		# render json: { current_user: "#{current_user.id}" }
		render 'index.json.jbuilder'
	end

	def show
		event_id = params[:id]
		@events = Event.where("user_id = ? AND id = ?", current_user.id, event_id)
		render 'index.json.jbuilder'
	end
end
