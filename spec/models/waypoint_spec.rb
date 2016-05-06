require 'rails_helper'

describe Waypoint, type: :model do

  it { is_expected.to belong_to :route }

end
