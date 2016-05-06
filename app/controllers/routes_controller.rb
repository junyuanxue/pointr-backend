class RoutesController < ApplicationController

  def index
    render json: Route.all
  end

  def show
    route = Route.find(params[:id])
    route_with_waypoints = { route: route,
                             waypoints: route.waypoints }
    render json: route_with_waypoints
  end
end
