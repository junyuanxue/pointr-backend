require 'rails_helper'

describe Route, type: :model do

  it { is_expected.to have_many :waypoints }
  
end
