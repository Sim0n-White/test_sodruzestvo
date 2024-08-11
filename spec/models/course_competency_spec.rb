require 'rails_helper'

RSpec.describe CourseCompetency, type: :model do
  describe 'associations' do
    it 'belongs to course' do
      association = CourseCompetency.reflect_on_association(:course)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to competency' do
      association = CourseCompetency.reflect_on_association(:competency)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
