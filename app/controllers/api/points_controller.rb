class Api::PointsController < ApplicationController

  def index
     @points_balance = Point.balance
     
     respond_to do |format|
      format.json {render json: @points_balance}
     end
  end
end
