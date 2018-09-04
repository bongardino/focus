class AddDisplayNameToAttendee < ActiveRecord::Migration[5.2]
  def change
    add_column :attendees, :display_name, :string
  end
end
