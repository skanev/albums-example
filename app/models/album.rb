class Album < ActiveRecord::Base
  belongs_to :user

  validates :name, :artist, :cover, presence: true

  attr_accessible :name, :artist, :cover

  mount_uploader :cover, CoverUploader
end
