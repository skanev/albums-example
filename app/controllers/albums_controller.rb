class AlbumsController < ApplicationController
  def index
    @albums = current_user.albums
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new params[:album]
    @album.user = current_user

    if @album.save
      redirect_to albums_path, notice: 'Album created successfully'
    else
      render :new
    end
  end
end
