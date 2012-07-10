Given 'I have an album "$name" by "$artist"' do |name, artist|
  create :album, name: name, artist: artist, user: @current_user
end

Given 'another user has uploaded an album "$name"' do |name|
  create :album, name: name
end

Given 'I have the following albums:' do |table|
  table.hashes.each do |row|
    create :album, user: @current_user, name: row['Name'], artist: row['Artist']
  end
end

When 'I upload an album "$name" by "$artist"' do |name, artist|
  visit new_album_path

  fill_in 'Name', with: name
  fill_in 'Artist', with: artist
  attach_file 'album[cover]', Rails.root.join('spec/images/cover.jpg')

  click_on 'Create'
end

When 'I attempt to upload an invalid album' do
  visit new_album_path

  click_on 'Create'
end

When 'I edit "$name" and change:' do |name, table|
  visit edit_album_path Album.find_by_name!(name)

  table.raw.each do |row|
    fill_in row.first, with: row.second
  end

  click_on 'Save'
end

When 'I attempt to edit "$name"' do |name|
  visit edit_album_path Album.find_by_name!(name)
end

When 'I search my albums for "$query"' do |query|
  visit albums_path
  fill_in 'Search', with: query
  click_on 'Search'
end

Then 'I should have an album "$name" by "$artist"' do |name, artist|
  visit albums_path

  page.should have_content "#{name} by #{artist}"
end

Then 'I should see that my album is invalid' do
  page.should have_content "can't be blank"
end

Then 'I should have found "$name" by "$artist"' do |name, artist|
  page.should have_content "#{name} by #{artist}"
end

Then 'I should have not found "$name" by "$artist"' do |name, artist|
  page.should_not have_content "#{name} by #{artist}"
end
