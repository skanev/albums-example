class AlbumsController < ApplicationController
  before_filter :require_user

  def index
    @albums = Album.search_user_albums current_user, params[:query]
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

  def edit
    @album = Album.find_by_id_and_user_id! params[:id], current_user.id
  end

  def update
    @album = Album.find_by_id_and_user_id! params[:id], current_user.id
    if @album.update_attributes params[:album]
      redirect_to albums_path, notice: 'Album updated successfully'
    else
      render :edit
    end
  end
end
