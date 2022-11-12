require "test_helper"

class EndpointTest < ActiveSupport::TestCase

  # Show
  test "Should create Endpoint successfully" do
    endpoint = Endpoint.new verb: "GET", path: "/test", endpoint_type: "endpoint", res_code: 200, res_headers: "{}", res_body: "all right"
    assert endpoint.save, "Failed to create endpoint"
  end

  # Create
  test "Should not create Endpoint without verb" do 
    endpoint = Endpoint.new path: "/test", endpoint_type: "endpoint", res_code: 200, res_headers: "{}", res_body: "all right"
    assert_not endpoint.save, "Saved an endpoint without verb"
  end

  test "Should not create Endpoint without type" do
    endpoint = Endpoint.new verb: "GET",  path: "/test", res_code: 200, res_headers: "{}", res_body: "all right"
    assert_not endpoint.save, "Saved an endpoint without type"
  end

  test "Should not create Endpoint with wrong verb" do
    endpoint = mock_endpoint
    endpoint.verb = "KNOCK"

    assert_not endpoint.save
  end

  test "res_code must be a valid response code" do
    endpoint = mock_endpoint
    endpoint.res_code = 199

    assert_not endpoint.save
  end

  # Update Endpoint
  test "Update endpoint" do
    endpoint = Endpoint.first
    assert endpoint.update verb: "PATCH"
  end

  test "Should not duplicate ids" do
    endpoint = Endpoint.first
    assert_raises(ActiveRecord::RecordNotUnique) do
      endpoint.update id: 2
    end
  end

  
end
