require 'swagger_helper'

RSpec.describe 'Competencies API', type: :request do
  let!(:competency) { create :competency }

  path '/competencies' do
    get 'Retrieves all competencies' do
      tags 'Competencies'
      produces 'application/json'

      response '200', 'competencies found' do
        schema type: :array, items: { '$ref': '#/components/schemas/competency' }

        before do
          Competency.create!(name: 'Sample Competency', description: 'Sample Description')
        end

        run_test!
      end
    end

    post 'Creates a competency' do
      tags 'Competencies'
      consumes 'application/json'
      parameter name: :competency, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        },
        required: ['name', 'description']
      }

      response '201', 'competency created' do
        let(:competency) { { name: 'New Competency', description: 'New Description' } }

        run_test!
      end

      response '422', 'invalid request' do
        let(:competency) { { name: '' } }

        run_test!
      end
    end
  end

  path '/competencies/{id}' do
    get 'Retrieves a competency' do
      tags 'Competencies'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'Competency ID'

      response '200', 'competency found' do
        schema '$ref': '#/components/schemas/competency'
        let(:id) { competency.id }

        run_test!
      end

      response '404', 'competency not found' do
        let(:id) { 'invalid' }

        run_test!
      end
    end

    put 'Updates a competency' do
      tags 'Competencies'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'Competency ID'
      parameter name: :updated_competency, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        },
        required: ['name', 'description']
      }

      response '200', 'competency updated' do
        schema '$ref': '#/components/schemas/competency'

        let(:id) { competency.id }
        let(:updated_competency) { { name: Faker::Job.title, description: Faker::Lorem.paragraph } }

        run_test!
      end

      response '404', 'competency not found' do
        let(:id) { 'invalid' }
        let(:updated_competency) { { name: Faker::Job.title, description: Faker::Lorem.paragraph } }

        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { competency.id }
        let(:updated_competency) { { name: '' } }

        run_test!
      end
    end

    delete 'Deletes a competency' do
      tags 'Competencies'
      parameter name: :id, in: :path, type: :integer, description: 'Competency ID'

      response '204', 'competency deleted' do
        let(:competency) { Competency.create!(name: 'Sample Competency', description: 'Sample Description') }
        let(:id) { competency.id }

        run_test!
      end

      response '404', 'competency not found' do
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end
end
