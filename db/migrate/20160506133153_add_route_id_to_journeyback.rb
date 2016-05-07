class AddRouteIdToJourneyback < ActiveRecord::Migration
  def change
    add_reference :journeybacks, :route, index: true, foreign_key: true
  end
end
