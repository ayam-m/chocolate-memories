class CreateRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :brand, foreign_key: true
      t.integer :record_type, null: false, index: true
      t.date :event_date, null: false
      t.string :recipient_name
      t.text :memo

      t.timestamps
    end
  end
end
