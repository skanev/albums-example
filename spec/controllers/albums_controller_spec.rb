require 'spec_helper'

describe AlbumsController do
  let(:current_user) { double 'current user' }

  describe "GET index" do
    it "assigns all the albums of the current user" do
      controller.stub current_user: current_user
      current_user.stub albums: 'albums'
      get :index
      assigns(:albums).should eq 'albums'
    end
  end

  describe "GET new" do
    it "assigns a new album" do
      Album.stub new: 'new-album'
      get :new
      assigns(:album).should eq 'new-album'
    end
  end

  describe "POST create" do
    let(:album) { double 'album' }

    before do
      controller.stub current_user: current_user
      Album.stub new: album
      album.stub :user=
      album.stub :save
    end

    it "builds a new album" do
      Album.should_receive(:new).with('album-attributes')
      post :create, album: 'album-attributes'
    end

    it "assigns the user of the new album to the current user" do
      album.should_receive(:user=).with(controller.current_user)
      post :create
    end

    it "attempts to save the album" do
      album.should_receive :save
      post :create
    end

    context "when successful" do
      it "redirects to the albums index" do
        post :create
        controller.should redirect_to albums_path
      end
    end
  end
end
