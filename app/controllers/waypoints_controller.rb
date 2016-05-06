class WaypointsController < ApplicationController
  respond_to :json

  def create
    route = Route.find(params[:route_id])
    waypoint = route.waypoints.new(waypoint_params)
    respond_with waypoint if waypoint.save
  end

  def waypoint_params
    params.require(:waypoint).permit(:latitude, :longitude)
  end
end
