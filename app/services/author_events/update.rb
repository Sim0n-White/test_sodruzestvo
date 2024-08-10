module AuthorEvents
  class Update
    def initialize(author, params)
      @author = author
      @params = params
    end

    def call
      return @author if @author.update(@params)

      { errors: @author.errors }
    end
  end
end
