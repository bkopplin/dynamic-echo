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
We'll start by querying the existing endpoints. 
```
curl "http://localhost:3000/endpoints" -X GET
```
There are no endpoints yet, hence we're getting an empty array. Let's add some endpoints!
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
                "body": "{ \"message\": \"Hello, world\" }"
            }
        }
    }
}'
```

# Usage Instructions
Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
