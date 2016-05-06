class WaypointsController < ApplicationController
  respond_to :json

  def index
    journey = Journey.find(params[:journey_id])
    render json: journey.waypoints.all
  end

  def create
    journey = Journey.find(params[:journey_id])
    waypoint = journey.waypoints.new(waypoint_params)
    respond_with waypoint if waypoint.save
  end

  def destroy
    waypoint = Waypoint.find(params[:id])
    waypoint.destroy
    render json: { status: 200 }
  end

  def waypoint_params
    params.require(:waypoint).permit(:latitude, :longitude)
  end
end
