require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:client) { Client.create!(name: "Test Client") }
  let(:pm) { Pm.create!(name: "Test PM") }
  let(:video_type1) { VideoType.create!(name: "Type 1", price: 100) }
  let(:video_type2) { VideoType.create!(name: "Type 2", price: 200) }
  let!(:project1) { Project.create!(name: "Project 1", client: client, pm: pm, status: "In Progress", created_at: 5.days.ago) }
  let!(:project2) { Project.create!(name: "Project 2", client: client, pm: pm, status: "In Progress", created_at: 2.days.ago) }

  before do
    project1.video_types << video_type1
    project2.video_types << video_type2
  end

  describe "associations" do
    it { should belong_to(:client) }
    it { should belong_to(:pm) }
    it { should have_many(:project_video_types) }
    it { should have_many(:video_types).through(:project_video_types) }
  end

  describe ".by_video_type" do
    it "returns projects with the given video type" do
      expect(Project.by_video_type(video_type1.id)).to include(project1)
      expect(Project.by_video_type(video_type1.id)).not_to include(project2)
    end
  end

  describe ".by_price_range" do
    it "returns projects within the price range" do
      expect(Project.by_price_range(50, 150)).to include(project1)
      expect(Project.by_price_range(50, 150)).not_to include(project2)
    end
  end

  describe ".by_creation_date_range" do
    it "returns projects within the date range" do
      expect(Project.by_creation_date_range(3.days.ago, Time.current)).to include(project2)
      expect(Project.by_creation_date_range(3.days.ago, Time.current)).not_to include(project1)
    end
  end
end
