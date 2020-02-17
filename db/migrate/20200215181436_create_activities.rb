class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.belongs_to :city, null: false, foreign_key: true
      t.string  :title
      t.string  :description
      t.string  :photo
      t.string :price

      t.timestamps
    end
  end
end
