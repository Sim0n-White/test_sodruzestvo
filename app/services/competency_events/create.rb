# frozen_string_literal: true

module CompetencyEvents
  class Create
    def initialize(params)
      @params = params
    end

    def call
      competency = Competency.new(@params)
      return competency if competency.save

      { errors: competency.errors }
    end
  end
end
