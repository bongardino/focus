class AddResponsetoEvents < ActiveRecord::Migration[5.2]
  def change
  	add_column :events, :response, :string
  end
end
