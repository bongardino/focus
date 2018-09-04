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
    user_email = email
    emails = Hash.new(0)
    events.each do |event|
      event.attendees.each do |attendee|
        if !attendee.email.include? "resource"
          emails[attendee.email] += 1
        end
      end
    end
    emails.delete(email)
    emails.sort_by {|_key, value| value}.reverse.to_h
  end

  def total_attendees
    total = 0
    attendees_tally.each do |attendee, count|
      total += count
    end
    total
  end

  def total_hours
    hours = 0
    events.each do |event|
      hours += event.duration
    end

    hours.round
  end

  def busy_days
    # this skips days with no events.  Its way less code but it makes for inconsistant graphs.
    # events.group_by_day(:start_time, format: "%A").count
    week = {
      Monday: 0,
      Tuesday: 0,
      Wednesday: 0,
      Thursday: 0,
      Friday: 0
    }

    events.each do |event|
      if event.start_time.presence && !event.one_to_one?
        if event.start_time.monday?
          week[:Monday] += 1
        elsif event.start_time.tuesday?
          week[:Tuesday] += 1
        elsif event.start_time.wednesday?
          week[:Wednesday] += 1
        elsif event.start_time.thursday?
          week[:Thursday] += 1
        elsif event.start_time.friday?
          week[:Friday] += 1
        end
      end
    end

    week
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

  def one_to_ones
    week = {
      Monday: 0,
      Tuesday: 0,
      Wednesday: 0,
      Thursday: 0,
      Friday: 0
    }

    events.each do |event|
      if event.start_time.presence && event.one_to_one?
        if event.start_time.monday?
          week[:Monday] += 1
        elsif event.start_time.tuesday?
          week[:Tuesday] += 1
        elsif event.start_time.wednesday?
          week[:Wednesday] += 1
        elsif event.start_time.thursday?
          week[:Thursday] += 1
        elsif event.start_time.friday?
          week[:Friday] += 1
        end
      end
    end

    week
  end

end
