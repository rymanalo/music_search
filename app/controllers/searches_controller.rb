class SearchesController < ApplicationController
  before_filter :authenticate_user!, :only => [:facebook]

  def index
    if user_signed_in?
      @current_user = current_user
    end
  end

  def sorry
    @query = params[:q]
  end

  def search
    @query = params[:q].strip
    @response = Search.new(@query)

    if (@query == "") || (@response.check_if_artist_exists == []) || (@response.check_if_artist_exists.nil?)
      redirect_to :action => 'sorry', :q => params[:q]
    else
      @response.artist_bio
      @response.artist_top_tracks
      @fb_id = @response.facebook_id.gsub!(/\D+/, '')
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

  def facebook
    @current_user = current_user
    @graph = Koala::Facebook::API.new(@current_user.oauth_token)
    @profile_pic = @graph.get_object("me?fields=picture")['picture']['data']['url']
    @music = @graph.get_connections("me", "music?fields=name")
  end

end