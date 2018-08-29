class Api::UsersController < ApplicationController
	def index
		p current_user
		@users = User.all
		# render json: { current_user: "#{current_user.id}" }
		render 'index.json.jbuilder'
	end

	def show
		# user_id = params[:id]
		@users = User.find(current_user.id)
		render 'index.json.jbuilder'
	end
end
