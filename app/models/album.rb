class Album < ActiveRecord::Base
  belongs_to :user

  validates :name, :artist, :cover, presence: true

  attr_protected :user_id, :created_at, :updated_at

  mount_uploader :cover, CoverUploader
end
