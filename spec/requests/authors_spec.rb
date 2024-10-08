require 'swagger_helper'

RSpec.describe 'Authors API', type: :request do
  path '/authors' do
    get 'Retrieves all authors' do
      tags 'Authors'
      produces 'application/json'

      response '200', 'authors found' do
        schema type: :array, items: { '$ref' => '#/components/schemas/author' }

        before do
          create_list(:author, 3)
        end

        run_test!
      end
    end

    post 'Creates a new author' do
      tags 'Authors'
      consumes 'application/json'
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name']
      }

      response '201', 'author created' do
        let(:author) { { name: Faker::Name.name } }

        run_test!
      end

      response '422', 'invalid request' do
        let(:author) { { name: '' } }

        run_test!
      end
    end
  end

  path '/authors/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Retrieves a specific author' do
      tags 'Authors'
      produces 'application/json'

      response '200', 'author found' do
        schema '$ref' => '#/components/schemas/author'

        let(:id) { create(:author).id }

        run_test!
      end

      response '404', 'author not found' do
        let(:id) { 'invalid' }

        run_test!
      end
    end

    put 'Updates an existing author' do
      tags 'Authors'
      consumes 'application/json'
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name']
      }

      response '200', 'author updated' do
        let(:id) { create(:author).id }
        let(:author) { { name: Faker::Name.name } }

        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { create(:author).id }
        let(:author) { { name: '' } }

        run_test!
      end
    end

    delete 'Deletes an existing author' do
      tags 'Authors'

      response '204', 'author deleted' do
        before do
          create(:author)
        end

        let(:id) { create(:author).id }
        run_test!
      end

      response '404', 'author not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '422', 'no other author' do
        let(:id) { create(:author).id }
        run_test!
      end
    end
  end
end
