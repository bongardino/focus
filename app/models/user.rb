class User < ApplicationRecord
  devise :trackable, :omniauthable, :timeoutable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
  	p auth
  	uid = auth.uid.downcase

  	user = find_or_initialize_by uid: uid
  	user.first_name = auth.info.first_name.presence
  	user.last_name = auth.info.last_name.presence
  	user.email = auth.info.email.presence
    user.token = auth.credentials.token
    user.refresh_token = auth.credentials.refresh_token
  	image_url = auth.info.image
  	user.save

  	user
  end



	# def self.from_omniauth(auth)
	# 	#i think this is double creating users.  fix it
	# 	binding.pry
	#   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	#     data = auth.info
	#     user = User.where(email: data['email']).first
	#     unless user
	#         user = User.create(
	#         	 first_name: data['first_name'],
	#         	 last_name: data['last_name'],
	#            email: data['email'],
	#            uid: auth.uid,
	#            image_url: data['image']
	#         )
	#     end
	#     user
	#   end
	# end

end
