FactoryBot.define do
  factory :course_competency do
    association :course
    association :competency
  end
end
