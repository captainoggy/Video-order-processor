class Project < ApplicationRecord
  belongs_to :client
  belongs_to :pm
  has_many :project_video_types
  has_many :video_types, through: :project_video_types
end
