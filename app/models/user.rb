class User < ApplicationRecord
  devise :trackable, :omniauthable, :timeoutable, omniauth_providers: [:google_oauth2]
  # has_many :user_events
  # has_many :events, through: :user_events
  has_many :events

  def self.from_omniauth(auth)
  	# p auth
  	uid = auth.uid.downcase

  	user = find_or_initialize_by uid: uid
  	user.first_name = auth.info.first_name.presence
  	user.last_name = auth.info.last_name.presence
  	user.email = auth.info.email.presence
    user.token = auth.credentials.token
    user.refresh_token = auth.credentials.refresh_token
  	user.image_url = auth.info.image
  	user.save

  	user
  end

  def attendees_tally
      ## Hash count mebe?
    emails = Hash.new(0)
    events.each do |event|
      event.attendees.each do |attendee|
        emails[ attendee.email ] += 1
      end
    end
    emails
  end

  def total_attendees
    total = 0
    attendees_tally.each do |attendee, count|
      total += count
    end
    total
  end

  # def token_refresh
  #   User.find_by uid: uid
  #   user.refresh_token = auth.credentials.refresh_token
  # end

  def total_hours
    hours = 0
    events.each do |event|
      hours += event.duration
    end

    hours.round
  end

  def busy_days
    events.group_by_day(:start_time, format: "%A").count
  end

  def durations
    week = {
      Monday: 0,
      Tuesday: 0,
      Wednesday: 0,
      Thursday: 0,
      Friday: 0
    }

    events.each do |event|
      if event.start_time.presence
        if event.start_time.monday?
          week[:Monday] += event.duration
        elsif event.start_time.tuesday?
          week[:Tuesday] += event.duration
        elsif event.start_time.wednesday?
          week[:Wednesday] += event.duration
        elsif event.start_time.thursday?
          week[:Thursday] += event.duration
        elsif event.start_time.friday?
          week[:Friday] += event.duration
        end
      end
    end

    week
  end

  # def events_by_uid
  # 	Event.where(user_uid: uid)
  # end

end
