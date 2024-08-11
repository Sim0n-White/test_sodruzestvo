require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'associations' do
    it 'has many courses' do
      association = Author.reflect_on_association(:courses)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'is invalid without a name' do
      author = Author.new(name: nil)
      expect(author).not_to be_valid
      expect(author.errors[:name]).to include("can't be blank")
    end

    it 'is valid with a name' do
      author = Author.new(name: Faker::Name.name)
      expect(author).to be_valid
    end
  end
end
