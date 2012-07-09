When 'I upload an album "$name" by "$artist"' do |name, artist|
  visit new_album_path

  fill_in 'Name', with: name
  fill_in 'Artist', with: artist

  click_on 'Create'
end

When 'I attempt to upload an invalid album' do
  visit new_album_path

  click_on 'Create'
end

Then 'I should have an album "$name" by "$artist"' do |name, artist|
  visit albums_path

  page.should have_content "#{name} by #{artist}"
end

Then 'I should see that my album is invalid' do
  page.should have_content "can't be blank"
end
