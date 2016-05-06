require 'rails_helper'

describe Journey, type: :model do

  it { is_expected.to have_many :waypoints }

end
