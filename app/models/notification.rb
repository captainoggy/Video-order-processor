class Notification < ApplicationRecord
  belongs_to :pm

  after_create_commit { broadcast_prepend_to "notifications.#{pm.id}", target: "notifications" }

  scope :by_creation_date_range, ->(start_date, end_date) {
    if start_date.present? && end_date.present?
      where(created_at: start_date..end_date)
    elsif start_date.present?
      where("created_at >= ?", start_date)
    elsif end_date.present?
      where("created_at <= ?", end_date)
    end
  }

  scope :by_message_keyword, ->(keyword) {
    where("message LIKE ?", "%#{sanitize_sql_like(keyword)}%") if keyword.present?
  }
end
