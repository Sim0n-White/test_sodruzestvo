module AuthorEvents
  class Create
    def initialize(params)
      @params = params
    end

    def call
      author = Author.new(@params)
      return author if author.save

      { errors: author.errors }
    end
  end
end
