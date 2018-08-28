class AddStatusToAttendeeEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :attendee_events, :status, :string
  end
end
