RSpec::Matchers.define :deny_access do
  include Albums::Application.routes.url_helpers

  match do |response|
    response.request.flash[:alert].present? and
      response.redirect_url.end_with? new_user_session_path
  end

  failure_message_for_should { |response| "expected action to deny access" }
end
