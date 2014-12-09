require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }
  
  describe "#recent_videos" do
    it "returns videos in reverse chronological order" do
      comedies = Category.create(name: "comedies")
      futurama = Video.create(title: "Futurama", description: "space travel", category: comedies, created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "crazy kids", category: comedies)
      expect(comedies.recent_videos).to eq([south_park, futurama])
    end
    it "returns all videos if less than six" do
      comedies = Category.create(name: "comedies")
      futurama = Video.create(title: "Futurama", description: "space travel", category: comedies, created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "crazy kids", category: comedies)
      expect(comedies.recent_videos).to eq([south_park, futurama])
    end
    it "returns at most 6" do
      comedies = Category.create(name: "comedies")
      7.times {Video.create(title: "foo", description: "bar", category: comedies)}
      expect(comedies.recent_videos.count).to eq(6)
    end
    it "returns the most recent 6" do
      comedies = Category.create(name: "comedies")
      futurama = Video.create(title: "Futurama", description: "space travel", category: comedies, created_at: 1.day.ago)
      7.times {Video.create(title: "foo", description: "bar", category: comedies)}
      expect(comedies.recent_videos).not_to include(futurama)
    end
    it "returns an empty array" do
      comedies = Category.create(name: "comedies")
      expect(comedies.recent_videos).to eq([])
    end
  end
end