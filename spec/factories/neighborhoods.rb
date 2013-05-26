FactoryGirl.define do
  factory :neighborhood do
    county 'Los Angeles'
    incorporated true
    source 'latimes'

    factory :chinatown do
      name 'Chinatown'
      city 'Los Angeles'
    end

    factory :culver_city do
      name 'Culver City'
      city 'Culver City'
    end

    factory :venice do
      name 'Venice'
      city 'Los Angeles'
    end
  end
end
