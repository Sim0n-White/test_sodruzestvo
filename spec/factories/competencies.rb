FactoryBot.define do
  factory :competency do
    name { Faker::Job.title }
    description { Faker::Lorem.paragraph }
  end
end
