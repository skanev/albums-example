When 'I upload an album "$name" by "$artist"' do |name, artist|
  visit new_album_path

  fill_in 'Name', with: name
  fill_in 'Artist', with: artist

  click_on 'Create'
end

Then 'I should have an album "$name" by "$artist"' do |name, artist|
  visit albums_path

  page.should have_content "#{name} by #{artist}"
end
