class AddAttendeecountToEvents < ActiveRecord::Migration[5.2]
  def change
  	add_column :events, :attendees_count, :integer
  end
end
