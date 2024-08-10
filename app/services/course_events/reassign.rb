module CourseEvents
  class Reassign
    def initialize(author)
      @from_author = author
    end

    def call
      new_author = select_author
      @from_author.courses.update_all(author_id: new_author.id)
    end

    private

    def select_author
      other_authors = Author.where.not(id: @from_author.id)
      best_author = common_competencies_author(other_authors)
      best_author.present? ? best_author : rand_author!(other_authors)
    end

    def common_competencies_author(other_authors)
      other_authors.joins(courses: :competencies)
        .where('competencies.id IN (?)', from_author_competencies)
        .group('authors.id')
        .order('COUNT(competencies.id) DESC')
        .first
    end

    def rand_author!(other_authors)
      author = other_authors.order('RANDOM()').first
      raise ActiveRecord::RecordNotFound, "Record not found" if author.blank?
      author
    end

    def from_author_competencies
      Competency.joins(courses: :author).where('authors.id = ?', @from_author.id).distinct.select(:id)
    end
  end
end
