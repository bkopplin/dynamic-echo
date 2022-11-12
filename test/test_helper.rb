ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def mock_endpoint
    endpoint = Endpoint.new(
       verb: "GET", 
       path: "/test", 
       endpoint_type: "endpoint", 
       res_code: 200, 
       res_headers: "{}", 
       res_body: "all right"
    )
  end
end
