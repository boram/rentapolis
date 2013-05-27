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
    venice_address

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
      street '727 North Broadway'
      city 'Los Angeles'
      state 'CA'
      zip '90012'
    end

    trait :culver_city_address do
      street '12565 Washington Blvd'
      city 'Los Angeles'
      state 'CA'
      zip '90066'
    end

    trait :venice_address do
      street '1600 Main Street'
      city 'Venice'
      state 'CA'
      zip '90291'
    end

    trait :without_geocoding do
      after(:build) do |rental|
        rental.class.skip_callback(:validation, :after, :geocode)
      end
    end

    factory :chinatown_apartment, traits: [:chinatown_address] do
      association :neighborhood, factory: :chinatown
      projected_coordinates 'POINT (-13162361.488248724 4037049.5286868075)'
    end

    factory :culver_city_apartment, traits: [:culver_city_address] do
      association :neighborhood, factory: :culver_city
      projected_coordinates 'POINT (-13183694.310186382 4028382.5569737027)'
    end

    factory :venice_apartment, traits: [:venice_address] do
      association :neighborhood, factory: :venice
      projected_coordinates 'POINT (-13188129.334359331 4027187.7317846473)'
    end
  end
end
