class Project < ApplicationRecord
  include Filterable

  belongs_to :client
  belongs_to :pm
  has_many :project_video_types
  has_many :video_types, through: :project_video_types

  enum :project_status, { in_progress: 0, completed: 1, needs_review: 2, cancelled: 3 }

  validates :name, presence: true
  validates :footage_link, presence: true
  validates :client, presence: true
  validates :pm, presence: true
  validate :must_have_at_least_one_video_type

  def must_have_at_least_one_video_type
    errors.add(:video_type_ids, "must select at least one video type") if video_types.empty?
  end

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
