Given 'a user "$email" with password "$password"' do |email, password|
  create :user, email: email, password: password
end

Given 'I am logged in' do
  user = create :user
  visit backdoor_login_path(email: user.email)
end

When 'I attempt to log in with email "$email" and password "$password"' do |email, password|
  visit new_user_session_path

  fill_in 'Email', with: email
  fill_in 'Password', with: password

  click_on 'Sign in'
end

When 'I register an account' do
  visit new_user_registration_path

  fill_in 'Email', with: generate(:email)
  fill_in 'Password', with: 'secret'
  fill_in 'Password confirmation', with: 'secret'

  click_on 'Sign up'
end

Then 'I should be logged in' do
  page.should have_content 'Logged in as'
end
