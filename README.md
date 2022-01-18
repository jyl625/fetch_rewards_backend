# README

## Introduction
* Language: **Ruby v2.5.1p57**
* Server-side web app framework: **Rails v5.2.6**
* Database: **PostgreSQL**
* Test suite: **RSpec**

## Requirements
* [Ruby v 2.5.x Installation](https://www.ruby-lang.org/en/documentation/installation/)
* [PostgreSQL](https://www.postgresql.org/download/)
* [Postman API Platform](https://www.postman.com) or any other platform for sending/receiving HTTP requests

## Project Setup
1. Download and unzip project from repo
2. Open project with the code editor of your choice
3. `cd` into project directory
4. Run `bundle install` to install gems(packages)
5. Run `bundle exec rails db:setup` to create and initialize database
    - If database needs to be reset at any point, run `bundle exec rails db:reset`
6. Run `rails s` to start Rails server 
    - Should be listening on `tcp://localhost:3000` as default

## How to run the RSpec test suite
0. Run `bundle install` (if not already completed)
1. Run `bundle exec rspec spec --format documentation` to run all the specs
    - To run specs just for the model, run `bundle exec rspec spec/models/point_spec.rb --format documentation`
    - To run specs just for the controller, run `bundle exec rspec spec/controllers/points_controller_spec.rb --format documentation`

## How to test HTTP requests and responses using Postman
### To post transactions
- Send `POST` request to `localhost:3000/api/add_transaction` with the following params:
  - payer: < string >
  - points: < integer >
  - timestamp: < string >
- Expected response should be in the form of:
  ```
  {
    "id": < integer >,
    "payer": < string >,
    "points": < integer >,
    "remaining_points": < integer >,
    "timestamp": < string >
  }
  ```
### To spend points
- Send `PATCH` request to `localhost:3000/api/spend_points` with the following param:
  - points: < integer >
- Expected response should be in the form of:
  ```
  [
    {
        "payer": < string >,
        "points": < integer >
    },
    {
        "payer": < string >,
        "points": < integer >
    }, 
    etc...
  ]
  ```
### To get balance
- Send `GET` requeset to `localhost:3000/api/points_balance`
- Expected response should be in the form of:
  ```
  {
    "payer_1": < integer >,
    "payer_2": < integer >, 
    etc...
  }
  ```

