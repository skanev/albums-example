require 'spec_helper'

describe HomeController do
  it "renders some welcome information to unauthenticated users" do
    controller.stub user_signed_in?: false
    get :index
    controller.should render_template :index
  end

  it "redirects authenticated users to their albums" do
    controller.stub user_signed_in?: true
    get :index
    controller.should redirect_to albums_path
  end
end
