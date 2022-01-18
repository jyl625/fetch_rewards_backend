class Api::PointsController < ApplicationController

  #For /api/points_balance
  def index
    #Point::balance returns points balance of each payer in appropriate format
    #Point::balance method definition found in Point model
    @points_balance = Point.balance
    
    respond_to do |format|
    format.json {render json: @points_balance}
    end
  end

  #For /api/add_transaction
  def create
    #Initializes new Point instance and saves into the database
    @points = Point.create(points_params)

    respond_to do |format|
      format.json {render json: @points, status: 200}
    end    
  end

  #For /api/spend_points
  def edit
    #Point::spend returns array of hashes where each hash has payer key and points key
    #Point::spend method definition found in Point model
    @summary = Point.spend(points_params[:points].to_i)

    respond_to do |format|
      format.json {render json: @summary}
    end
  end

  private

  #Private method for permitting specific params in the HTTP request
  def points_params
    params.permit(
      :payer,
      :points,
      :timestamp
    )
  end
end
