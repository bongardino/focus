class User < ApplicationRecord
  devise :trackable, :omniauthable, :timeoutable, omniauth_providers: [:google_oauth2]

	def self.from_omniauth(auth)
		#i think this is double creating users.  fix it
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    data = auth.info
	    user = User.where(email: data['email']).first
	    unless user
	        user = User.create(
	        	 first_name: data['first_name'],
	        	 last_name: data['last_name'],
	           email: data['email'],
	           uid: auth.uid,
	           image_url: data['image']
	        )
	    end
	    user
	  end
	end

end
