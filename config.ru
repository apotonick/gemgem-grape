# This file is used by Rack-based servers to start the application.
require "rack"
use Rack::Reloader

require_relative "application"
run API::Application
