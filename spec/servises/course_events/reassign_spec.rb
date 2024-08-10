require 'rails_helper'

RSpec.describe CourseEvents::Reassign, type: :service do
  let!(:author1) { create(:author) }
  let!(:author2) { create(:author) }
  let!(:author3) { create(:author) }

  let!(:competency1) { create(:competency) }
  let!(:competency2) { create(:competency) }

  let!(:course1) { create(:course, author: author1) }
  let!(:course2) { create(:course, author: author1) }
  let!(:course3) { create(:course, author: author2) }

  before do
    create(:course_competency, course: course1, competency: competency1)
    create(:course_competency, course: course2, competency: competency2)
    create(:course_competency, course: course3, competency: competency2)
  end

  describe '#call' do
    context 'when there are other authors with common competencies' do
      it 'assigns courses to the author with the most common competencies' do
        service = CourseEvents::Reassign.new(author1)
        service.call

        expect(course1.reload.author).to eq(author2)
        expect(course2.reload.author).to eq(author2)
      end
    end

    context 'when there are no other authors' do
      before do
        Author.delete_all
      end

      it 'raises an error when no other authors are available' do
        service = CourseEvents::Reassign.new(author1)

        expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when there are other authors but no common competencies' do
      let(:author4) { create(:author) }

      before do
        create(:course, author: author4)
      end

      it 'assigns courses randomly if no common competencies are found' do
        service = CourseEvents::Reassign.new(author1)
        service.call

        expect(Course.where(author: author4).count).to be > 0
      end
    end
  end
end
