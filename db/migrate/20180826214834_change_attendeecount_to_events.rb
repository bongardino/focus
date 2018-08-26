class ChangeAttendeecountToEvents < ActiveRecord::Migration[5.2]
  def change
  	remove_column :events, :attendees_count, :integer
  	add_column :events, :attendee_count, :integer
  end
end
