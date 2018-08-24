class EventsEventIDtoEventId < ActiveRecord::Migration[5.2]
  def change
  	remove_column :events, :eventid
  	add_column :events, :uid, :string
  end
end
