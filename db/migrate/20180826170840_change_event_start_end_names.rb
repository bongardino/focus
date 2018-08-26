class ChangeEventStartEndNames < ActiveRecord::Migration[5.2]
  def change
  	add_column :events, :start_time, :string
  	add_column :events, :end_time, :string
  	remove_column :events, :start
  	remove_column :events, :end
  end
end
