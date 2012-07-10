class Album < ActiveRecord::Base
  belongs_to :user

  validates :name, :artist, :cover, presence: true

  attr_protected :user_id, :created_at, :updated_at

  mount_uploader :cover, CoverUploader

  def self.search_user_albums(user, query)
    scope = scoped
    scope = scope.search(*query.split(' ')) if query.present?
    scope = scope.where(user_id: user.id)
    scope.all
  end
end
