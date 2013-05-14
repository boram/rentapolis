FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Vincent #{n}" }
    sequence(:email) { |n| "user-#{n}@example.com" }
    password 'asdf1234'

    factory :facebook_user do
      provider 'facebook'
      sequence(:uid) { |n| "1000#{n}" }
      first_name 'Vincent'
      last_name 'Hanna'
      avatar { "http://graph.facebook.com/#{uid}/picture?type=square" }
      url "http://www.facebook.com/vincent"
      location "Los Angeles"
      oauth_token "ABCD1234"
      oauth_expires_at { 2.years.from_now }
    end
  end
end
