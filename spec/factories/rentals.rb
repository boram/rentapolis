FactoryGirl.define do
  factory :rental do
    description <<-EOL.strip_heredoc
      You probably haven't heard of them odio swag, lomo 8-bit irure occaecat voluptate pop-up dreamcatcher
      butcher tofu accusamus narwhal. Id scenester organic keffiyeh. Photo booth lo-fi tempor master
      cleanse. Cosby sweater lo-fi DIY semiotics leggings banh mi. Dolor labore laboris gentrify.
      Farm-to-table biodiesel sunt beard, helvetica voluptate sriracha pickled. Exercitation tumblr mlkshk,
      photo booth food truck do nulla dolore id lomo blog ut.
    EOL
    beds 1
    baths 1
    unit_type 'apartment'
    sqft 600
    rent 1200.00
    rent_per 'month'
    deposit 1200.00
    chinatown_address

    factory :single do
      beds nil
      baths nil
      unit_type 'single'
      sqft 300
      rent 800.00
      rent_per 'month'
      deposit 600.00

      factory :bachelor do
        unit_type 'bachelor'
      end
    end

    trait :chinatown_address do
      association :neighborhood, factory: :chinatown
      street '727 North Broadway'
      city 'Los Angeles'
      state 'CA'
      zip '90012'
    end

    trait :culver_city_address do
      association :neighborhood, factory: :culver_city
      street '12565 Washington Blvd'
      city 'Los Angeles'
      state 'CA'
      zip '90066'
    end

    trait :venice_address do
      association :neighborhood, factory: :venice
      street '822 West Washington Blvd'
      city 'Los Angeles'
      state 'CA'
      zip '90291'
    end

    factory :chinatown_apartment, traits: [:chinatown_address]
    factory :culver_city_apartment, traits: [:culver_city_address]
    factory :venice_apartment, traits: [:venice_address]
  end
end
