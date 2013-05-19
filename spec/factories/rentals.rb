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
    street '1216 Brockton Avenue'
    city 'Los Angeles'
    state 'CA'
    zip '90025'

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
  end
end
