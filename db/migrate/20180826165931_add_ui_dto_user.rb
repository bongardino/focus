class AddUiDtoUser < ActiveRecord::Migration[5.2]
  def change
  	add_column :events, :user_uid, :string
  end
end
