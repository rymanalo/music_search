class SearchesController < ApplicationController

  def index
  end

  def search

    @query = params[:q]
    @response = Search.new(@query)
    @response.artist_bio
    @response.artist_top_tracks
    @response.top_video

  end

end