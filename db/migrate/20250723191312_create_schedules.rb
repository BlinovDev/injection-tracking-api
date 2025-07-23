class CreateSchedules < ActiveRecord::Migration[8.0]
  def change
    create_table :schedules do |t|
      t.integer :interval_in_days, null: false
      t.string :drug_name, null: false
      t.date :starts_on, null: false, default: -> { 'CURRENT_DATE' }
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
