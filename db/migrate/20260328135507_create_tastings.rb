class CreateTastings < ActiveRecord::Migration[7.2]
  def change
    create_table :tastings do |t|
      t.references :record, null: false, foreign_key: true
      t.integer :sweetness
      t.integer :richness
      t.integer :melting

      t.timestamps
    end
  end
end
