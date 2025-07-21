require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:pm) { Pm.create!(name: "Test PM") }
  let!(:old_notification) { Notification.create!(pm: pm, message: "Old message", created_at: 5.days.ago) }
  let!(:recent_notification) { Notification.create!(pm: pm, message: "Recent message", created_at: 1.day.ago) }
  let!(:keyword_notification) { Notification.create!(pm: pm, message: "Special keyword here", created_at: 2.days.ago) }

  describe "unread logic" do
    it "is unread by default" do
      n = Notification.create!(pm: pm, message: "Test")
      expect(n.read).to eq(false)
    end
  end

  describe ".by_creation_date_range" do
    it "returns notifications within the date range" do
      results = Notification.by_creation_date_range(3.days.ago, Time.current)
      expect(results).to include(recent_notification, keyword_notification)
      expect(results).not_to include(old_notification)
    end
  end

  describe ".by_message_keyword" do
    it "returns notifications matching the keyword" do
      results = Notification.by_message_keyword("keyword")
      expect(results).to include(keyword_notification)
      expect(results).not_to include(old_notification, recent_notification)
    end
  end
end
