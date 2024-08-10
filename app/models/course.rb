class Course < ApplicationRecord
  belongs_to :author
  has_many :course_competencies
  has_many :competencies, through: :course_competencies

  validates :title, :description, presence: true
end
