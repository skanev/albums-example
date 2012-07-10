require 'spec_helper'

describe AlbumsController do
  let(:current_user) { double 'current user', id: '1' }

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

  describe "GET edit" do
    let(:album) { double 'album' }

    before do
      Album.stub find_by_id_and_user_id!: album
    end

    it "denies access to unauthenticated user" do
      controller.stub current_user: nil
      get :edit, id: '1'
      response.should deny_access
    end

    it "looks up the album by id and user" do
      Album.should_receive(:find_by_id_and_user_id!).with('42', current_user.id)
      get :edit, id: '42'
    end

    it "assings the album" do
      get :edit, id: '1'
      assigns(:album).should eq album
    end
  end

  describe "PUT update" do
    let(:album) { double 'album' }

    before do
      Album.stub find_by_id_and_user_id!: album
      album.stub :update_attributes
    end

    it "denies access to unauthenticated user" do
      controller.stub current_user: nil
      get :update, id: '1'
      response.should deny_access
    end

    it "looks up the album by id and user" do
      Album.should_receive(:find_by_id_and_user_id!).with('42', current_user.id)
      get :update, id: '42'
    end

    it "attempts to update the album" do
      album.should_receive(:update_attributes).with('album-attributes')
      get :update, id: '42', album: 'album-attributes'
    end

    context "when successful" do
      before do
        album.stub update_attributes: true
      end

      it "redirects to the list of albums" do
        get :update, id: '42'
        controller.should redirect_to albums_path
      end

      it "sets a flash notice" do
        get :update, id: '42'
        flash[:notice].should be_present
      end
    end

    context "when unsuccessful" do
      before do
        album.stub update_attributes: false
      end

      it "rerenders the edit form" do
        get :update, id: '42'
        controller.should render_template :edit
      end
    end
  end
end
