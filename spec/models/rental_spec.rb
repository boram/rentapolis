require 'spec_helper'

describe Rental do
  describe 'validations' do
    let(:rental) { Rental.new }

    describe 'beds' do
      it 'has the presence error' do
        expect(rental.errors_on(:beds)).to include("can't be blank")
      end

      context 'when unit_type is bachelor' do
        before { rental.unit_type = 'bachelor' }

        it 'is not required' do
          expect(rental).to have(:no).errors_on(:beds)
        end
      end

      context 'when unit_type is single' do
        before { rental.unit_type = 'single' }

        it 'is not required' do
          expect(rental).to have(:no).errors_on(:beds)
        end
      end
    end

    describe 'baths' do
      it 'has the presence error' do
        expect(rental.errors_on(:baths)).to include("can't be blank")
      end

      context 'when unit_type is bachelor' do
        before { rental.unit_type = 'bachelor' }

        it 'is not required' do
          expect(rental).to have(:no).errors_on(:baths)
        end
      end

      context 'when unit_type is single' do
        before { rental.unit_type = 'single' }

        it 'is not required' do
          expect(rental).to have(:no).errors_on(:baths)
        end
      end
    end

    describe 'unit_type' do
      it 'has the presence error' do
        expect(rental.errors_on(:unit_type)).to include("can't be blank")
      end
    end

    describe 'description' do
      it 'has the presence error' do
        expect(rental.errors_on(:description)).to include("can't be blank")
      end
    end

    describe 'rent' do
      it 'has the presence error' do
        expect(rental.errors_on(:rent)).to include("can't be blank")
      end
    end

    describe 'rent_per' do
      it 'has the presence error' do
        expect(rental.errors_on(:rent_per)).to include("can't be blank")
      end
    end

    describe 'street' do
      it 'has the presence error' do
        expect(rental.errors_on(:street)).to include("can't be blank")
      end
    end

    describe 'city' do
      it 'has the presence error' do
        expect(rental.errors_on(:city)).to include("can't be blank")
      end
    end

    describe 'state' do
      it 'has the presence error' do
        expect(rental.errors_on(:state)).to include("can't be blank")
      end
    end

    describe 'zip' do
      it 'has the presence error' do
        expect(rental.errors_on(:zip)).to include("can't be blank")
      end
    end
  end

  describe '#address' do
    let(:rental) do
      build :rental, street: '12565 Washington Blvd',
        city: 'Los Angeles', state: 'CA', zip: '90066'
    end

    it 'concatenates street, city, state and zip' do
      expect(rental.address).to eq('12565 Washington Blvd, Los Angeles CA 90066')
    end
  end

  describe 'coordinates', :vcr do
    context 'given a new record' do
      let(:rental) do
        build :rental, :culver_city_address
      end

      before { rental.save! }

      it 'geocodes the address' do
        expect(rental.projected_coordinates).to be_kind_of(RGeo::Geos::CAPIPointImpl)
        expect(rental.latitude).to be_within(0.0000001).of 33.9968760
        expect(rental.longitude).to be_within(0.0000001).of -118.4311410
      end
    end

    context 'given an existing record' do
      let(:rental) { create :culver_city_apartment }

      before do
        rental.update_attributes street: '727 North Broadway',
          city: 'Los Angeles', state: 'CA', zip: '90012'
      end

      it 'updates the coordinates' do
        expect(rental.latitude).to be_within(0.0000001).of 34.06140
        expect(rental.longitude).to be_within(0.0000001).of -118.2395050
      end
    end
  end

  describe '#neighborhood', :vcr do
    context 'given an address in a neighborhood' do
      let!(:venice_polygon) { create :venice_polygon }

      let(:rental) do
        build :rental, :venice_address, neighborhood: nil
      end

      before { rental.save! }

      it 'builds an association to it' do
        expect(rental.neighborhood).to eq(venice_polygon.neighborhood)
      end
    end
  end
end
