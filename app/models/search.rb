class Search < ActiveRecord::Base
  attr_accessible :query

  def initialize(q)
    @query = q

  end

  def artist_bio
    file = open("http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=#{URI.escape(@query)}&api_key=fadbdbd5d7730cebc746dafafe0c7050&format=json")
    @bio = JSON.load(file.read)["artist"]["bio"]['summary']
  end

  def artist_top_tracks
    file = open("http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=#{URI.escape(@query)}&limit=10&api_key=fadbdbd5d7730cebc746dafafe0c7050&format=json")
    @top_tracks = JSON.load(file.read)['toptracks']['track'].map {|t| t['name']}
  end

end
