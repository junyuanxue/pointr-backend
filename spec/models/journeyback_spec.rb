require 'rails_helper'

describe Journeyback, type: :model do

  it { is_expected.to belong_to :route }

end
