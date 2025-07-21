require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let(:client) { Client.create!(name: "Test Client") }
  let(:pm) { Pm.create!(name: "Test PM") }
  let!(:project1) { Project.create!(name: "Project 1", client: client, pm: pm, status: "In Progress", created_at: 5.days.ago) }
  let!(:project2) { Project.create!(name: "Project 2", client: client, pm: pm, status: "In Progress", created_at: 2.days.ago) }

  before do
    allow(NotificationJob).to receive(:perform_now)
    allow_any_instance_of(ApplicationController).to receive(:session).and_return({ user_type: "client", user_id: client.id })
    allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_call_original
  end

  describe "GET /projects" do
    it "renders the index page successfully" do
      get projects_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Projects")
    end

    it "filters projects by creation date range" do
      get projects_path, params: { start_date: 3.days.ago.to_date, end_date: Time.current.to_date }
      expect(response.body).to include("Project 2")
      expect(response.body).not_to include("Project 1")
    end
  end

  describe "GET /projects/new" do
    it "renders the new project form" do
      get new_project_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Create Your Masterpiece")
    end
  end

  describe "POST /projects" do
    it "creates a new project and redirects" do

      expect {
        post projects_path, params: { project: { name: "New Project", footage_link: "http://example.com" } }
      }.to change(Project, :count).by(1)

      expect(response).to redirect_to(projects_path)
    end
  end
end
