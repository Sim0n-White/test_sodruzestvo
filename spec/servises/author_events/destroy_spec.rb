require 'rails_helper'

RSpec.describe AuthorEvents::Destroy, type: :service do
  let!(:author) { create(:author) }
  let!(:other_author) { create(:author) }
  let!(:competency) { create(:competency) }
  let!(:course) { create(:course, author: author) }
  let!(:course_competency) { create(:course_competency, course: course, competency: competency) }

  before do
    course.update(author: author)
  end

  describe '#call' do
    context 'when the author is successfully deleted and courses are reassigned' do
      it 'reassigns courses to another author' do
        service = AuthorEvents::Destroy.new(author)
        result = service.call

        expect(result).to eq({ success: true })
        expect { author.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect(course.reload.author).not_to eq(author)
        expect(course.reload.author).to be_present
      end
    end

    context 'when there are no other authors to reassign courses to' do
      before do
        Author.where.not(id: author.id).destroy_all
      end

      it 'raises an error and does not delete the author' do
        service = AuthorEvents::Destroy.new(author)
        result = service.call

        expect(result).to have_key(:errors)
        expect(result[:errors]).to include('Record not found')
        expect(Author.exists?(author.id)).to be_truthy
      end
    end

    context 'when an error occurs during the destroy process' do
      before do
        allow_any_instance_of(CourseEvents::Reassign).to receive(:call).and_raise(StandardError, 'Something went wrong')
      end

      it 'handles the error and does not delete the author' do
        service = AuthorEvents::Destroy.new(author)
        result = service.call

        expect(result).to have_key(:errors)
        expect(result[:errors]).to eq('Something went wrong')
        expect(Author.exists?(author.id)).to be_truthy
      end
    end
  end
end
