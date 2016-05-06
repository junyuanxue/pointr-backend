class WaypointsController < ApplicationController
  respond_to :json

  def index
    route = Route.find(params[:route_id])
    render json: route.waypoints.all
  end

  def create
    route = Route.find(params[:route_id])
    waypoint = route.waypoints.new(waypoint_params)
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
