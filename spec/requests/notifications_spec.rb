require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let(:pm) { Pm.create!(name: "Test PM") }
  let!(:notification1) { Notification.create!(pm: pm, message: "First", created_at: 2.days.ago) }
  let!(:notification2) { Notification.create!(pm: pm, message: "Second", created_at: 1.day.ago) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:session).and_return({ user_type: "pm", user_id: pm.id })
    allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_call_original
  end

  describe "GET /notifications" do
    it "renders the index page successfully" do
      get notifications_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Notifications")
    end

    it "paginates notifications" do
      15.times { Notification.create!(pm: pm, message: "Extra") }
      get notifications_path
      expect(response.body).to include("Notifications")
      expect(response.body).to include("Page navigation").or include("pagy")
    end
  end

  describe "GET /notifications/:id" do
    it "shows a notification and marks it as read" do
      expect(notification1.read).to eq(false)
      get notification_path(notification1)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(notification1.message)
      expect(notification1.reload.read).to eq(true)
    end
  end
end
