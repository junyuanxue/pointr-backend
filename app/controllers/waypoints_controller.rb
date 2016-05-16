class WaypointsController < ApplicationController
  respond_to :json
  skip_before_filter :verify_authenticity_token

  def index
    journey = Journey.find(params[:journey_id])
    render json: journey.waypoints.all
  end

  def create
    journey = Journey.find(params[:journey_id])
    waypoint = journey.waypoints.new(waypoint_params)
    respond_with waypoint if waypoint.save
  end

  def update
    waypoint = Waypoint.find(params[:id])
    waypoint.update(waypoint_params)
    render json: waypoint
  end

  def destroy
    waypoint = Waypoint.find(params[:id])
    waypoint.destroy
    render json: { status: 200 }
  end

  def waypoint_params
    params.require(:waypoint).permit(:latitude, :longitude, :description)
  end
end
