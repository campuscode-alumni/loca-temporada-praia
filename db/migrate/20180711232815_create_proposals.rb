class CreateProposals < ActiveRecord::Migration[5.2]
  def change
    create_table :proposals do |t|
      t.date :start_date
      t.date :end_date
      t.integer :total_guests
      t.boolean :pet
      t.references :property, foreign_key: true
      t.string :rent_purpose

      t.timestamps
    end
  end
end
