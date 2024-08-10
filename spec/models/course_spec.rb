require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:author) { create(:author) }
  let(:competency) { create(:competency) }
  let(:course) { create(:course, author: author) }

  describe 'associations' do
    it 'belongs to an author' do
      expect(course.author).to eq(author)
    end

    it 'has many competencies through course competencies' do
      course.competencies << competency
      expect(course.competencies).to include(competency)
    end
  end

  describe 'validations' do
    it 'is invalid without a title' do
      course.title = nil
      expect(course).not_to be_valid
      expect(course.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a description' do
      course.description = nil
      expect(course).not_to be_valid
      expect(course.errors[:description]).to include("can't be blank")
    end

    it 'is valid with a title and description' do
      course.title = 'Valid Title'
      course.description = 'Valid Description'
      expect(course).to be_valid
    end
  end
end
