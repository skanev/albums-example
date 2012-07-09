class BackdoorController < ApplicationController
  def login
    raise 'This exception should never occur' unless Rails.env.test? # Famous last words
    sign_in User.find_by_email!(params[:email])
    render text: 'OK'
  end
end
