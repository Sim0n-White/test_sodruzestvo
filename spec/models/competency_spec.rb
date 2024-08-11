require 'rails_helper'

RSpec.describe Competency, type: :model do
  describe 'associations' do
    it 'has many course_competencies' do
      association = Competency.reflect_on_association(:course_competencies)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many courses through course_competencies' do
      association = Competency.reflect_on_association(:courses)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:course_competencies)
    end
  end

  describe 'validations' do
    it 'is invalid without a name' do
      competency = Competency.new(description: Faker::Lorem.paragraph)
      expect(competency).not_to be_valid
      expect(competency.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a description' do
      competency = Competency.new(name: Faker::Job.title)
      expect(competency).not_to be_valid
      expect(competency.errors[:description]).to include("can't be blank")
    end

    it 'is valid with valid attributes' do
      competency = Competency.new(name: Faker::Job.title, description: Faker::Lorem.paragraph)
      expect(competency).to be_valid
    end
  end
end
