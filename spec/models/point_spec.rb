require 'rails_helper'

RSpec.describe Point, type: :model do

  it { should validate_presence_of(:payer)}
  it { should validate_presence_of(:points)}
  it { should validate_presence_of(:remaining_points)}
  it { should validate_presence_of(:timestamp)}

  describe 'remaining points' do
    it 'assigns remaining points equal to points when initialized' do
      Point.create!(payer: 'DANNON', points: 700, timestamp: "2022-01-01T00:00:00Z")
      expect(subject.remaining_points).to eq(subject.points)
    end
  end

  Point.create("payer": "DANNON", "points": 1000, "timestamp": "2020-11-02T14:00:00Z") 
  Point.create("payer": "UNILEVER", "points": 200, "timestamp": "2020-10-31T11:00:00Z") 
  Point.create("payer": "DANNON", "points": -200, "timestamp": "2020-10-31T15:00:00Z") 
  Point.create("payer": "MILLER COORS", "points": 10000, "timestamp": "2020-11-01T14:00:00Z") 
  Point.create("payer": "DANNON", "points": 300, "timestamp": "2020-10-31T10:00:00Z") 

  describe 'spend' do 
    it 'returns array of {"payer": <string>, "points": <integer>}' do

      response = [ 
        { "payer": "DANNON", "points": -100 }, 
        { "payer": "UNILEVER", "points": -200 }, 
        { "payer": "MILLER COORS", "points": -4700 } 
      ]
      expect(Point.spend(5000)).to eq(response)
    end
  end

  describe 'balance' do 
    it 'after spending, returns point balance for each payer' do 
      Point.spend(5000)
      balance = {"DANNON"=> 1000, "UNILEVER"=> 0, "MILLER COORS"=> 5300}

      expect(Point.balance).to eq(balance)
    end
  end

end