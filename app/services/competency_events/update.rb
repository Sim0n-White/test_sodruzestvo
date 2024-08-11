# frozen_string_literal: true

module CompetencyEvents
  class Update
    def initialize(competency, params)
      @competency = competency
      @params = params
    end

    def call
      return @competency if @competency.update(@params)

      { errors: @competency.errors }
    end
  end
end
