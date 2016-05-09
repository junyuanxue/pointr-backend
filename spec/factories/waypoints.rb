include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :waypoint do
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    description { Faker::Hipster.sentence }
    journey
  end
end
