class CreateJourneybacks < ActiveRecord::Migration
  def change
    create_table :journeybacks do |t|

      t.timestamps null: false
    end
  end
end
