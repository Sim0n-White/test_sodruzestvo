class CreateCompetencies < ActiveRecord::Migration[6.1]
  def change
    create_table :competencies do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
