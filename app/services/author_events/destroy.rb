# frozen_string_literal: true

module AuthorEvents
  class Destroy
    def initialize(author)
      @author = author
    end

    def call
      ActiveRecord::Base.transaction do
        CourseEvents::Reassign.new(@author).call
        @author.destroy!
      end
      { success: true }
    rescue => e
      { errors: e.message }
    end
  end
end
