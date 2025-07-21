module Filterable
  extend ActiveSupport::Concern

  included do
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
      where("message LIKE ?", "%#{sanitize_sql_like(keyword)}%") if keyword.present? && column_names.include?("message")
    }
  end
end
