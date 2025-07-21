class CreateVideoTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :video_types do |t|
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
