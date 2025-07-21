class Project < ApplicationRecord
  include Filterable
  belongs_to :client
  belongs_to :pm
  has_many :project_video_types
  has_many :video_types, through: :project_video_types

  scope :by_video_type, ->(video_type_id) {
    joins(:video_types).where(video_types: { id: video_type_id }) if video_type_id.present?
  }

  scope :by_price_range, ->(min_price, max_price) {
    if min_price.present? && max_price.present?
      joins(:video_types).group("projects.id").having("SUM(video_types.price) BETWEEN ? AND ?", min_price, max_price)
    elsif min_price.present?
      joins(:video_types).group("projects.id").having("SUM(video_types.price) >= ?", min_price)
    elsif max_price.present?
      joins(:video_types).group("projects.id").having("SUM(video_types.price) <= ?", max_price)
    end
  }
end
