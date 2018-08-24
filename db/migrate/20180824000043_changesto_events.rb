class ChangestoEvents < ActiveRecord::Migration[5.2]
  def change
  	add_column :events, :user_id, :integer
  	add_column :events, :summary, :string
  	remove_column :events, :status
  	remove_column :events, :description
  end
end
