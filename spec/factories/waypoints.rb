include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :waypoint do
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    journey
  end
end
