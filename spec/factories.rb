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
  end
end
