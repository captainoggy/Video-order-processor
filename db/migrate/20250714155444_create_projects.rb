class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :footage_link, null: false
      t.string :status, null: false
      t.references :client, null: false, foreign_key: true
      t.references :pm, null: false, foreign_key: true

      t.timestamps
    end
  end
end
