FactoryGirl.define do
  sequence(:email) { |n| "user-#{n}@example.org" }

  factory :user do
    email
    password 'secret'
  end

  factory :album do
    user
    name 'Name'
    artist 'Artist'
    cover { Rack::Test::UploadedFile.new Rails.root.join('spec/images/cover.jpg').to_s }
  end
end
