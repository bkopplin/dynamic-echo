# Dynamic Echo

An Echo Server that servers dynamic mock endpoints. 
  
# Dependencies

* Ruby 2.7.2
* Ruby on Rails 7.0.4
* sqlite 3.31.1

# Local Deployment
1. Make sure the dependencies above are met.
2. Clone this repository: 
   ```
   git clone https://github.com/bkopplin/dynamic-echo.git
   ```
3. Run database migrations: 
   ```
   bin/rails db:migrate RAILS_ENV=development
   ```
4. [Optional] Run the test suite 
   ```
   bin/rails test
   ```
5. Start the server (http://localhost:3000 by default): 
   ```
   bin/rails server
   ```

# Usage
Let's start by querying for existing endpoints:
```
curl "http://localhost:3000/endpoints" -X GET
```
You should get an empty array because there are no endpoints yet. Let's change that! Create an endpoint using the following command.
```
curl --request POST \
  --url http://localhost:3000/endpoints \
  --header 'Content-Type: application/json' \
  --data '
{
    "data": {
        "type": "endpoints",
        "attributes": {
          "verb": "GET",
          "path": "/greetings",
            "response": {
                "code": 200,
                "headers": {},
                "body": "Hello World"
            }
        }
    }
}'
```
When you run `curl "http://localhost:3000/endpoints" -X GET` again, you should now see one endpoint.

Let's access this endpoint.
```
curl "http://localhost:3000/greetings" -X GET
```
You can also update the endpoint:
```
curl --request PATCH \
  --url http://localhost:3000/endpoints/1 \
  --header 'Content-Type: application/json' \
  --data '{
    "data": {
        "type": "endpoint",
        "id": "1",
        "attributes": {
            "verb": "POST",
            "path": "/greetings",
            "response": {
              "code": 501,
              "headers": {},
              "body": "Hi there"
            }
        }
    }
}'
```
Finally, let's delete the endpoint all togeher:
```
curl http://localhost:3000/endpoints/1 -X DELETE
```


