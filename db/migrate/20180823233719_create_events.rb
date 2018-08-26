class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :start
      t.string :end
      t.string :creator
      t.string :created
      t.string :description
      t.string :status
      t.boolean :repeating
      t.string :etag
      t.string :url
      t.string :eventid

      t.timestamps
    end
  end
end
