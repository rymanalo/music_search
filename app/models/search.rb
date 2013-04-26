class Search < ActiveRecord::Base
  attr_accessible :query


  def initialize(q)
    @query = q
  end

  def check_if_artist_exists
    file = open("http://developer.echonest.com/api/v4/artist/biographies?api_key=#{ENV["echo_key"]}&name=#{URI.escape(@query)}&format=json&results=1&start=0&license=cc-by-sa")
    JSON.load(file.read)["response"]["biographies"]
  end

  def artist_bio
    file = open("http://developer.echonest.com/api/v4/artist/biographies?api_key=#{ENV["echo_key"]}&name=#{URI.escape(@query)}&format=json&results=1&start=0&license=cc-by-sa")
    JSON.load(file.read)["response"]["biographies"][0]['text']
  end

  def artist_top_tracks
    #file = open("http://developer.echonest.com/api/v4/artist/songs?api_key=#{ENV["echo_key"]}&name=#{URI.escape(@query)}&format=json&start=0&results=10")
    #JSON.load(file.read)["response"]["songs"].map {|t| t['title']}
    file = open("http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=#{URI.escape(@query)}&limit=10&api_key=#{ENV["lastfm_key"]}&format=json")
    JSON.load(file.read)['toptracks']['track'].map {|t| t['name']}
  end

  def top_videos_youtube_ids
    artist_top_tracks.map do |track| 
      YoutubeSearch.search("#{track} #{@query}").first["video_id"]
    end
  end

  def check_if_image_nil
    file = open("http://developer.echonest.com/api/v4/artist/images?api_key=#{ENV["echo_key"]}&name=#{URI.escape(@query)}&format=json&results=1&start=0&license=unknown")
    JSON.load(file.read)["response"]["images"][0].nil?
  end

  def artist_image
    file = open("http://developer.echonest.com/api/v4/artist/images?api_key=#{ENV["echo_key"]}&name=#{URI.escape(@query)}&format=json&results=1&start=0&license=unknown")
    JSON.load(file.read)["response"]["images"][0]['url']
  end

  def facebook_id
    file = open("http://developer.echonest.com/api/v4/artist/profile?api_key=#{ENV["echo_key"]}&name=#{URI.escape(@query)}&format=json&bucket=id:facebook")
    JSON.load(file.read)["response"]["artist"]["foreign_ids"][0]['foreign_id']
  end
end
