class Api::PointsController < ApplicationController

  def index
     @points_balance = Point.balance
     
     respond_to do |format|
      format.json {render json: @points_balance}
     end
  end

  def edit
    p points_params
    @summary = Point.spend(points_params[:points].to_i)

    respond_to do |format|
      format.json {render json: @summary}
    end
  end

  def points_params
    params.permit(:points)
  end
end
