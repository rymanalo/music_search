class Search < ActiveRecord::Base
  attr_accessible :query

  def initialize(q)
    @query = q

  end

  def check_if_artist_nil
    file = open("http://developer.echonest.com/api/v4/artist/biographies?api_key=#{ENV["echo_key"]}&name=#{URI.escape(@query)}&format=json&results=1&start=0&license=cc-by-sa")
    JSON.load(file.read)["response"]["biographies"].nil?
  end

  def artist_bio
    file = open("http://developer.echonest.com/api/v4/artist/biographies?api_key=#{ENV["echo_key"]}&name=#{URI.escape(@query)}&format=json&results=1&start=0&license=cc-by-sa")
    JSON.load(file.read)["response"]["biographies"][0]['text']
  end

  def artist_top_tracks
    file = open("http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=#{URI.escape(@query)}&limit=10&api_key=#{ENV["lastfm_key"]}&format=json")
    JSON.load(file.read)['toptracks']['track'].map {|t| t['name']}
  end

  def top_videos_youtube_ids
    artist_top_tracks.map do |track| 
      YoutubeSearch.search("#{track} #{@query}").first["video_id"]
    end
  end

  def check_if_image_nil
    file = open("http://developer.echonest.com/api/v4/artist/biographies?api_key=#{ENV["echo_key"]}&name=#{URI.escape(@query)}&format=json&results=1&start=0&license=cc-by-sa")
    JSON.load(file.read)["response"]["image"].nil?
  end

  def artist_image
    file = open("http://developer.echonest.com/api/v4/artist/images?api_key=#{ENV["echo_key"]}&name=#{URI.escape(@query)}&format=json&results=1&start=0&license=unknown")
    JSON.load(file.read)["response"]["images"][0]['url']
  end
end
