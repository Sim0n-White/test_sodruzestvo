module CourseEvents
  class Update
    def initialize(course, params)
      @course = course
      @params = params
    end

    def call
      return @course if @course.update(@params)

      { errors: @course.errors }
    end
  end
end
