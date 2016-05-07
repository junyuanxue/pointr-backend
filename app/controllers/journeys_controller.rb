class JourneysController < ApplicationController
  respond_to :json

  skip_before_filter :verify_authenticity_token

  def index
    render json: Journey.all
  end

  def create
    journey = Journey.new
    respond_with journey if journey.save
  end

  def show
    journey = Journey.find(params[:id])
    journey_with_waypoints = { journey: journey,
                             waypoints: journey.waypoints }
    render json: journey_with_waypoints
  end

  def destroy
    journey = Journey.find(params[:id])
    journey.destroy
    render json: { status: 200 }
  end
end
