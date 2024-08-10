require 'rails_helper'

RSpec.describe AuthorEvents::Create, type: :service do
  let(:valid_params) { { name: Faker::Name.name } }
  let(:invalid_params) { { name: '' } }

  describe '#call' do
    context 'with valid parameters' do
      it 'creates a new author and returns the author object' do
        service = AuthorEvents::Create.new(valid_params)
        result = service.call

        expect(result).to be_a(Author)
        expect(result).to be_persisted
        expect(result.name).to eq(valid_params[:name])
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new author and returns errors' do
        service = AuthorEvents::Create.new(invalid_params)
        result = service.call

        expect(result).to be_a(Hash)
        expect(result[:errors]).to be_present
        expect(result[:errors][:name]).to include("can't be blank")
      end
    end
  end
end
