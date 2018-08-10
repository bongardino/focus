class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable, :omniauthable, :timeoutable, omniauth_providers: [:google_oauth2]

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    data = auth.info
	    user = User.where(email: data['email']).first
	    # Uncomment the section below if you want users to be created if they don't exist
	    unless user
	        user = User.create(name: data['name'],
	           email: data['email'],
	           password: Devise.friendly_token[0,20]
	        )
	    end
	    user
	  end
	end

end
