include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :waypoint do
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    route
  end
end
