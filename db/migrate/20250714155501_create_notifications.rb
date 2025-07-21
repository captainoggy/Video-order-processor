class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.string :message, null: false
      t.references :pm, null: false, foreign_key: true
      t.boolean :read, default: false, null: false

      t.timestamps
    end
  end
end
