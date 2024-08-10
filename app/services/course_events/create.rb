module CourseEvents
  class Create
    def initialize(params)
      @params = params
    end

    def call
      course = Course.new(@params)
      return course if course.save

      { errors: course.errors }
    end
  end
end
