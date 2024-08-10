require 'rails_helper'

RSpec.describe CourseEvents::Update, type: :service do
  let(:author) { create(:author, name: Faker::Name.name) }
  let!(:course) { create(:course, author: author) }
  let(:valid_params) do
    {
      title: Faker::Educator.course_name,
      description: Faker::Lorem.paragraph,
      author_id: author.id
    }
  end
  let(:invalid_params) { { title: '', description: '', author_id: '' } }

  describe '#call' do
    context 'with valid parameters' do
      it 'updates the course and returns the course object' do
        service = CourseEvents::Update.new(course, valid_params)
        result = service.call

        expect(result).to be_a(Course)
        expect(result).to be_persisted
        expect(result.title).to eq(valid_params[:title])
        expect(result.description).to eq(valid_params[:description])
      end
    end

    context 'with invalid parameters' do
      it 'does not updates the course and returns errors' do
        service = CourseEvents::Update.new(course, invalid_params)
        result = service.call

        expect(result).to be_a(Hash)
        expect(result[:errors]).to be_present
        expect(result[:errors][:title]).to include("can't be blank")
        expect(result[:errors][:description]).to include("can't be blank")
      end
    end
  end
end
