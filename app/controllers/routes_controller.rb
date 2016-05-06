class RoutesController < ApplicationController
  respond_to :json

  def index
    render json: Route.all
  end

  def create
    route = Route.new
    respond_with route if route.save
  end

  def show
    route = Route.find(params[:id])
    route_with_waypoints = { route: route,
                             waypoints: route.waypoints }
    render json: route_with_waypoints
  end

  def destroy
    route = Route.find(params[:id])
    route.destroy
    render json: { status: 200 }
  end
end
