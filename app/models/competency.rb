class Competency < ApplicationRecord
  has_many :course_competencies
  has_many :courses, through: :course_competencies

  validates :name, :description, presence: true
end
