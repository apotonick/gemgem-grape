require "test_helper"

class PostIntegrationTest < Minitest::Spec
  include Rack::Test::Methods

  let (:params) { { title: "Like!" } }

  it do
    post "/v1/posts", params.to_json
    last_response.status.must_equal 201
    last_response.body.must_equal %{"{}"}
  end
end
