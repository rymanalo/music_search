class Search < ActiveRecord::Base
  attr_accessible :query

  def initialize(q)
    @query = q

  end

  def artist_bio
    file = open("http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=#{URI.escape(@query)}&api_key=#{ENV["api_key"]}&format=json")
    JSON.load(file.read)["artist"]["bio"]['summary']
  end

  def artist_top_tracks
    file = open("http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=#{URI.escape(@query)}&limit=10&api_key=#{ENV["api_key"]}&format=json")
    JSON.load(file.read)['toptracks']['track'].map {|t| t['name']}
  end

  def top_video
    YoutubeSearch.search(@query).first["video_id"]
  end

end
