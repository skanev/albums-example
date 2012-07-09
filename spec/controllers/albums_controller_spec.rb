require 'spec_helper'

describe AlbumsController do
  let(:current_user) { double 'current user' }

  before do
    controller.stub current_user: current_user
  end

  describe "GET index" do
    it "denies access to unauthenticated user" do
      controller.stub current_user: nil
      get :index
      response.should deny_access
    end

    it "assigns all the albums of the current user" do
      controller.stub current_user: current_user
      current_user.stub albums: 'albums'
      get :index
      assigns(:albums).should eq 'albums'
    end
  end

  describe "GET new" do
    it "denies access to unauthenticated user" do
      controller.stub current_user: nil
      get :new
      response.should deny_access
    end

    it "assigns a new album" do
      Album.stub new: 'new-album'
      get :new
      assigns(:album).should eq 'new-album'
    end
  end

  describe "POST create" do
    let(:album) { double 'album' }

    before do
      Album.stub new: album
      album.stub :user=
      album.stub :save
    end

    it "denies access to unauthenticated user" do
      controller.stub current_user: nil
      post :create
      response.should deny_access
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
      before do
        album.stub save: true
      end

      it "redirects to the albums index" do
        post :create
        controller.should redirect_to albums_path
      end

      it "sets a flash notice" do
        post :create
        flash[:notice].should be_present
      end
    end

    context "when unsuccessful" do
      before do
        album.stub save: false
      end

      it "assings the album" do
        post :create
        assigns(:album).should eq album
      end

      it "rerenders the album form" do
        post :create
        controller.should render_template :new
      end
    end
  end
end
