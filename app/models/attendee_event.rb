class AttendeeEvent < ApplicationRecord
	belongs_to :attendee
	belongs_to :event

	validates_uniqueness_of :attendee_id, :scope => [:event_id]
end
