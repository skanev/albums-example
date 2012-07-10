require 'spec_helper'

describe Album do
  it { should validate_presence_of :name }
  it { should validate_presence_of :artist }
  it { should validate_presence_of :cover }

  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :artist }
  it { should_not allow_mass_assignment_of :user_id }

  describe "searching" do
    it "finds albums by parts of their name" do
      'supreme'.should find_album album(name: 'A Love Supreme')
    end

    it "finds albums by parts of their artist" do
      'coltrane'.should find_album album(artist: 'John Coltrane')
    end

    it "finds matches both in name and artist" do
      'coltrane love'.should find_album album(name: 'A Love Supreme', artist: 'John Coltrane')
    end

    it "finds all albums if given an empty query" do
      ''.should find_album album
      nil.should find_album album
    end

    it "does not find albums, owned by other users" do
      user  = create :user
      album = create :album, artist: 'John Coltrane'

      Album.search_user_albums(user, 'coltrane').should_not include album
      Album.search_user_albums(user, '').should_not include album
    end

    def album(attributes = {})
      create :album, attributes
    end

    RSpec::Matchers.define :find_album do |album|
      match do |query|
        Album.search_user_albums(album.user, query).include? album
      end
    end
  end
end
