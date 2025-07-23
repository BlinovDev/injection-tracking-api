class CreateInjections < ActiveRecord::Migration[8.0]
  def change
    create_table :injections do |t|
      t.integer :dose, null: false
      t.string :lot_number, null: false
      t.datetime :injected_at, null: false
      t.references :schedule, null: false, foreign_key: true

      t.timestamps
    end
  end
end
