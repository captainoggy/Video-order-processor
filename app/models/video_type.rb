class VideoType < ApplicationRecord
  has_many :project_video_types
  has_many :projects, through: :project_video_types
end
