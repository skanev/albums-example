class AlbumsController < ApplicationController
  def index
    @albums = current_user.albums
  end

  def new
    @album = Album.new
  end

  def create
    album = Album.new params[:album]
    album.user = current_user
    album.save
    redirect_to albums_path
  end
end
