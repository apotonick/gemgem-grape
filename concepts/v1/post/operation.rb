module Post
  class Create < Trailblazer::Operation
    def process(params)
    end

    def to_json(*) # called in Grape's run!.
      "{}"
    end
  end
end
