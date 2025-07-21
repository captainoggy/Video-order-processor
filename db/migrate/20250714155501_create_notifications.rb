class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.string :message
      t.references :pm, null: false, foreign_key: true

      t.timestamps
    end
  end
end
