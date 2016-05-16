include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :journey do
    description { Faker::Hipster.sentence }
  end
end
