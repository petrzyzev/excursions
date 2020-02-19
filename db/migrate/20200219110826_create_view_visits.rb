class CreateViewVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :view_visits do |t|
      t.integer :view_id
      t.integer :visit_id
      t.references :activity

      t.timestamps
    end
  end
end
