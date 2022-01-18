class Api::PointsController < ApplicationController

  def index
     @points_balance = Point.balance
     
     respond_to do |format|
      format.json {render json: @points_balance}
     end
  end

  def create
    @points = Point.create(points_params)

    respond_to do |format|
      format.json {render json: @points, status: 200}
    end    
  end

  def edit
    @summary = Point.spend(points_params[:points].to_i)

    respond_to do |format|
      format.json {render json: @summary}
    end
  end

  private

  def points_params
    params.permit(
      :payer,
      :points,
      :timestamp
    )
  end
end
