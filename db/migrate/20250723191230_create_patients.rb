class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|
      t.string :name, null: false
      t.string :api_key, null: false

      t.timestamps
    end
    add_index :patients, :api_key, unique: true
  end
end
