class SearchesController < ApplicationController
  before_filter :authenticate_user!, :only => [:facebook]

  def index
  end

  def sorry
    @query = params[:q]
  end

  def search
    @query = params[:q]
    @response = Search.new(@query)

    if @response.check_if_artist_nil
      redirect_to :action => 'sorry', :q => params[:q]
    else
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

  def friends
    if user_signed_in?
      @current_user = current_user
    end
  end

  def facebook
    @current_user = current_user
    @graph = Koala::Facebook::API.new(@current_user.oauth_token)

    @profile = @graph.get_object("me")
    @friends = @graph.get_connections("me", "friends")

    #@friends = @graph.get_connections("me", "friends", :fields => "picture,name,birthday,hometown,location")[0..20]
    friend_count = params[:friend_count].to_i
    @music = @graph.get_connections("me", "music?fields=name")
  end

end