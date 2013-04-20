class SearchesController < ApplicationController

  def index
  end

  def sorry
    @query = params[:q]
  end

  def search

    @query = params[:q]
    @response = Search.new(@query)

    # if @response.check_if_artist_nil
    #   redirect_to :action => 'sorry', :q => params[:q]
    # else
      @response.artist_bio
      @response.artist_top_tracks
      array = @response.top_videos_youtube_ids
      @top_video = array.shift
      @top_video_playlist = array.join(",")
    if @response.check_if_image_nil
      @artist_image = true
    else
      @artist_image = false
      @response.artist_image
    end
  end

end