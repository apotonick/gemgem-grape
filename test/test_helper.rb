require_relative "../application"
require "minitest/autorun"
require "rack/test"

Minitest::Spec.class_eval do
  def app
    API::Application
  end
end
