require 'spec_helper'

describe RentalSerializer do
  include ActionView::Helpers::NumberHelper

  shared_context 'rental' do
    let(:rental) do
      create :venice_apartment, :without_geocoding
    end

    let(:rental_serializer) do
      RentalSerializer.new rental
    end
  end

  describe '#id' do
    include_context 'rental'

    it 'is rendered' do
      expect(rental_serializer.id).to eq rental.id
    end
  end

  describe '#posted_at' do
    include_context 'rental'

    let(:formatted_posted_at) do
      I18n.l rental.updated_at, format: :datetime
    end

    it 'is datetime formatted' do
      expect(rental_serializer.posted_at).to eq formatted_posted_at
    end
  end

  describe '#short_description' do
    context 'by default' do
      include_context 'rental'

      let(:short_description) do
        "#{rental.beds} bed #{rental.baths} bath #{rental.unit_type}"
      end

      it 'displays beds, baths and unit type' do
        expect(rental_serializer.short_description).to eq short_description
      end
    end

    context 'given a bachelor' do
      let(:rental) do
        create :bachelor, :without_geocoding
      end

      let(:rental_serializer) do
        RentalSerializer.new rental
      end

      it 'displays the unit type only' do
        expect(rental_serializer.short_description).to eq 'bachelor'
      end
    end

    context 'given a single' do
      let(:rental) do
        build :single, :without_geocoding
      end

      let(:rental_serializer) do
        RentalSerializer.new rental
      end

      it 'displays the unit type only' do
        expect(rental_serializer.short_description).to eq 'single'
      end
    end
  end

  describe '#sqft' do
    include_context 'rental'

    it 'is rendered' do
      expect(rental_serializer.sqft).to eq rental.sqft
    end
  end

  describe '#description' do
    include_context 'rental'

    it 'is rendered' do
      expect(rental_serializer.description).to eq rental.description
    end
  end

  describe '#rent' do
    include_context 'rental'

    let(:formatted_rent) do
      "#{number_to_currency(rental.rent)}/#{rental.rent_per}"
    end

    it 'is currency formatted' do
      expect(rental_serializer.rent).to eq formatted_rent
    end
  end

  describe '#deposit' do
    include_context 'rental'

    let(:formatted_deposit) do
      number_to_currency rental.deposit
    end

    it 'is currency formatted' do
      expect(rental_serializer.deposit).to eq formatted_deposit
    end
  end

  describe '#street_address' do
    include_context 'rental'

    let(:street_address) { rental.street }

    it 'is rendered' do
      expect(rental_serializer.street_address).to eq street_address
    end
  end

  describe '#region' do
    include_context 'rental'

    let(:region) { rental.region }

    it 'is rendered' do
      expect(rental_serializer.region).to eq region
    end
  end

  describe '#latitude' do
    include_context 'rental'

    it 'is rendered' do
      expect(rental_serializer.latitude).to eq rental.latitude
    end
  end

  describe '#longitude' do
    include_context 'rental'

    it 'is rendered' do
      expect(rental_serializer.longitude).to eq rental.longitude
    end
  end

  describe '#neighborhood' do
    include_context 'rental'

    it 'is rendered' do
      expect(rental_serializer.neighborhood).to eq(rental.neighborhood.name)
    end
  end

  describe '#neighborhood_id' do
    include_context 'rental'

    it 'is rendered' do
      expect(rental_serializer.neighborhood_id).to eq(rental.neighborhood.id)
    end
  end
end