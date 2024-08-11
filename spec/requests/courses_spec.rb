require 'swagger_helper'

RSpec.describe 'Courses API', type: :request do
  let(:author) { create(:author) }
  let(:competency) { create(:competency) }
  let!(:course) { create(:course, author: author, competency_ids: [competency.id]) }

  path '/courses' do
    get 'Retrieves all courses' do
      tags 'Courses'
      produces 'application/json'

      response '200', 'courses found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   description: { type: :string },
                   author_id: { type: :integer },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: [ 'id', 'title', 'description', 'author_id', 'created_at', 'updated_at' ]
               }

        run_test!
      end
    end

    post 'Creates a course' do
      tags 'Courses'
      consumes 'application/json'
      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          author_id: { type: :integer },
          competency_ids: { type: :array, items: { type: :integer } }
        },
        required: [ 'title', 'description', 'author_id' ]
      }

      response '201', 'course created' do
        let(:course) do
          {
            title: 'New Course',
            description: 'Course description',
            author_id: author.id,
            competency_ids: [competency.id]
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:course) { { title: '' } }

        run_test!
      end
    end
  end

  path '/courses/{id}' do
    get 'Retrieves a course' do
      tags 'Courses'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'Course ID'

      response '200', 'course found' do
        schema '$ref': '#/components/schemas/course'
        let(:id) { course.id }

        run_test!
      end

      response '404', 'course not found' do
        let(:id) { 'invalid' }

        run_test!
      end
    end

    put 'Updates a course' do
      tags 'Courses'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'Course ID'
      parameter name: :course_params, in: :body, schema: {
        type: :object,
        required: %w[title description author_id],
        properties: {
          title: { type: :string },
          description: { type: :string },
          author_id: { type: :integer },
          competency_ids: { type: :array, items: { type: :integer } }
        }
      }

      response '200', 'course updated' do
        let(:id) { course.id }
        let(:course_params) do
          {
            title: Faker::Educator.course_name,
            description: Faker::Lorem.paragraph,
            author_id: course.author_id
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { course.id }
        let(:course_params) do
          {
            title: '',
            description: Faker::Lorem.paragraph,
            author_id: course.author_id
          }
        end

        run_test!
      end

      response '404', 'course not found' do
        let(:id) { 'non_existent_id' }
        let(:course_params) do
          {
            title: Faker::Educator.course_name,
            description: Faker::Lorem.paragraph,
            author_id: course.author_id
          }
        end

        run_test!
      end
    end

    delete 'Deletes a course' do
      tags 'Courses'
      parameter name: :id, in: :path, type: :integer, description: 'Course ID'

      response '204', 'course deleted' do
        let(:id) { course.id }

        run_test!
      end

      response '404', 'course not found' do
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end
end
