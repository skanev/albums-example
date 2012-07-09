class Album < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :artist, presence: true

  attr_accessible :name, :artist
end
