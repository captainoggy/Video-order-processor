class CreateProjectVideoTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :project_video_types do |t|
      t.references :project, null: false, foreign_key: true
      t.references :video_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
