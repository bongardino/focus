class AddColumnToAttendeeEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :attendee_events, :event_id, :integer
    add_column :attendee_events, :attendee_id, :integer
  end
end
