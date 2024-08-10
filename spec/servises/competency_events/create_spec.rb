require 'rails_helper'

RSpec.describe CompetencyEvents::Create, type: :service do
  let(:valid_params) { { name: Faker::Job.title, description: Faker::Lorem.paragraph } }
  let(:invalid_params) { { name: '', description: '' } }

  describe '#call' do
    context 'with valid parameters' do
      it 'creates a new competency and returns the competency object' do
        service = CompetencyEvents::Create.new(valid_params)
        result = service.call

        expect(result).to be_a(Competency)
        expect(result).to be_persisted
        expect(result.name).to eq(valid_params[:name])
        expect(result.description).to eq(valid_params[:description])
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new competency and returns errors' do
        service = CompetencyEvents::Create.new(invalid_params)
        result = service.call

        expect(result).to be_a(Hash)
        expect(result[:errors]).to be_present
        expect(result[:errors][:name]).to include("can't be blank")
        expect(result[:errors][:description]).to include("can't be blank")
      end
    end
  end
end
