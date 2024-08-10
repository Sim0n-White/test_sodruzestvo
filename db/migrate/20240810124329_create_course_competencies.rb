class CreateCourseCompetencies < ActiveRecord::Migration[6.1]
  def change
    create_table :course_competencies do |t|
      t.references :course, null: false
      t.references :competency, null: false

      t.timestamps
    end
  end
end
