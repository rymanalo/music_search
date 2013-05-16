require_relative '../spec_helper'

describe Search do

  it "initializes with a query" do
    @q = Search.new("kaskade")
  end

  it "checks if the artist exists" do
    @q = Search.new("kaskade")
    @q.check_if_artist_exists.should_not be_nil
  end

  it "gets artists bio" do
    @q = Search.new("kaskade")
    @q.artist_bio.should_not be_nil
  end

  it "gets artists top tracks" do
    @q = Search.new("kaskade")
    @q.artist_top_tracks.should_not be_nil
  end

  it "gets top videos on youtube" do
    @q = Search.new("kaskade")
    @q.top_videos_youtube_ids.should_not be_nil
  end

  it "checks if image of artist exists" do
    @q = Search.new("kaskade")
    @q.check_if_image_nil.should_not be_nil
  end

  it "gets image of artist" do
    @q = Search.new("kaskade")
    @q.artist_image.should_not be_nil
  end

  it "gets facebook fan page id" do
    @q = Search.new("kaskade")
    @q.facebook_id.should_not be_nil
  end

end