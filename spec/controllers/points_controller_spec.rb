require 'rails_helper'

RSpec.describe Api::PointsController, type: :controller do
  describe 'GET #index' do 
    it 'returns the balance of each payer' do
      Point.create("payer": "DANNON", "points": 1000, "timestamp": "2020-11-02T14:00:00Z") 
      Point.create("payer": "UNILEVER", "points": 200, "timestamp": "2020-10-31T11:00:00Z") 
      Point.create("payer": "DANNON", "points": -200, "timestamp": "2020-10-31T15:00:00Z") 
      Point.create("payer": "MILLER COORS", "points": 10000, "timestamp": "2020-11-01T14:00:00Z") 
      Point.create("payer": "DANNON", "points": 300, "timestamp": "2020-10-31T10:00:00Z")
      Point.spend(5000)
      get :index, format: :json
      balance = {"DANNON"=> 1000, "UNILEVER"=> 0, "MILLER COORS"=> 5300}
      expect(JSON.parse(response.body)).to eq(balance)
    end
  end

  describe 'POST #create' do
    it 'posts point transaction' do 
      post :create, params:{payer: "DANNON", points: 1000, timestamp: "2020-11-02T14:00:00Z"}, format: :json
      response_body = Point.last.serializable_hash.as_json
      expect(JSON.parse(response.body)).to eq(response_body)
    end
  end

  describe 'PATCH #edit' do
    it 'spends points and returns array of points spent on each payer' do
      Point.create("payer": "DANNON", "points": 1000, "timestamp": "2020-11-02T14:00:00Z") 
      Point.create("payer": "UNILEVER", "points": 200, "timestamp": "2020-10-31T11:00:00Z") 
      Point.create("payer": "DANNON", "points": -200, "timestamp": "2020-10-31T15:00:00Z") 
      Point.create("payer": "MILLER COORS", "points": 10000, "timestamp": "2020-11-01T14:00:00Z") 
      Point.create("payer": "DANNON", "points": 300, "timestamp": "2020-10-31T10:00:00Z")
      patch :edit, params:{points: 5000},format: :json
      response_body = [ 
        { "payer"=> "DANNON", "points"=> -100 }, 
        { "payer"=> "UNILEVER", "points"=> -200 }, 
        { "payer"=> "MILLER COORS", "points"=> -4700 } 
      ]
      expect(JSON.parse(response.body)).to eq(response_body)
    end
  end
  
end