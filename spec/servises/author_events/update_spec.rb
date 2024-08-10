require 'rails_helper'

RSpec.describe AuthorEvents::Update, type: :service do
  let!(:author) { create(:author, name: Faker::Name.name) }
  let(:valid_params) { { name: Faker::Name.name } }
  let(:invalid_params) { { name: '' } }

  describe '#call' do
    context 'with valid parameters' do
      it 'updates the author and returns the author object' do
        service = AuthorEvents::Update.new(author, valid_params)
        result = service.call

        expect(result).to be_a(Author)
        expect(result.name).to eq(valid_params[:name])
        expect(result).to be_persisted
      end
    end

    context 'with invalid parameters' do
      it 'does not update the author and returns errors' do
        service = AuthorEvents::Update.new(author, invalid_params)
        result = service.call

        expect(result).to be_a(Hash)
        expect(result[:errors]).to be_present
        expect(result[:errors][:name]).to include("can't be blank")
        expect(author.reload.name).to eq(author.name)
      end
    end
  end
end
