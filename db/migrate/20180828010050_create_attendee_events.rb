class CreateAttendeeEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :attendee_events do |t|

      t.timestamps
    end
  end
end
