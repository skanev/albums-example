class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :albums
end
