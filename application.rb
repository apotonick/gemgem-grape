require "grape"
require "active_record"
require "trailblazer"
require "trailblazer/loader"
require "reform/form/active_model/validations"
require "yajl" # DISCUSS: why do we use this, again?

module API
  class Application < Grape::API
    format :json
    # prefix :api # if you want /api/v1/posts

    # rescue_from ActiveRecord::RecordNotFound do |e|
    #   error!({ status: 404, message: "Record not found" }, 404)
    # end

    # rescue_from Trailblazer::NotAuthorizedError do |e|
    #   error!({ status: 401, message: "Wrong credentials" }, 401)
    # end

    version :v1 do
      get("posts")  { run!(Post::Show, request) }
      post("posts") { run!(Post::Create, request) }
    end

    helpers do
      def run!(operation_class, request)
        parser = Yajl::Parser.new(symbolize_keys: true)
        params = parser.parse(request.body.read)

        # run the actual operation.
        operation_class.(params).to_json
        # rescue
        #   pp $!.message
        #   pp $!.backtrace
      end
    end
         # TODO: figure out why request isn't available in helper.
  end
end

# DISCUSS: leave that here or move somewhere else?
Reform::Form.class_eval do
  include Reform::Form::ActiveModel::Validations
end

Trailblazer::Loader.new.(concepts_root: "./concepts/", debug: true) { |file| require_relative("#{file}") }

require_relative "database"
