require "test_helper"

class EndpointFlowTest < ActionDispatch::IntegrationTest

  test "can fetch endpoints" do
    get "/endpoints"
    assert_equal 3, response.parsed_body["data"].length, "Wrong number of endpoints received"
    assert_equal 200, status    
  end

  test "get empty array when no endpoints exist" do 
    Endpoint.destroy_all
    get "/endpoints"
    assert_equal response.parsed_body, {"data" => []}
    assert_equal 200, status

  end

  test "create a post" do
    post "/endpoints", params: { data: {
      type: "endpoint",
      attributes: {
        verb: "GET",
        path: "/ahoy",
        response: {
          code: 200,
          headers: {
            "Server" => "Apache"
          },
          body: "This is Apache"
        }
      }
    }}, as: :json
    assert_equal "/ahoy", Endpoint.last.path
    assert_equal 201, status
  end

  test "Should not create an endpoint that already exists" do 
  
  end

  # Update

  test "Should not update a non-existing endpoint" do
    patch "/endpoints/42000"
    assert_equal 404, status # Not Found
  end

  test "Should update an endpoint" do 
    patch "/endpoints/2", params: { data: {
      type: "endpoint",
      id: 2,
      attributes: {
        verb: "DELETE",
        path: "/dogs",
        response: {
          code: 200,
          headers: {},
          body: "The dog is being deleted. How does that work?"
        }
      }
    }}, as: :json
    assert_equal 200, status
    assert_equal Endpoint.find(2).verb, "DELETE"
  end

  #Delete

  test "Deletes an endpoint" do 
    delete "/endpoints/1"
    assert_equal 204, status # No Content
  end

  test "Responds with not found if the endpoint to be deleted doesn't exist" do
    # delete "/endpoints/42000"
    # assert_equal 404, status # Not Found
  end

  # Dynamic Endpoints
  test "Should not access a non-existent endpoint" do

  end

  test "Should access an existing endpoint" do
    
  end

  test "Should not access a valid path with the wrong verb" do

  end
end
