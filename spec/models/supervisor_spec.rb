require 'spec_helper'

describe Supervisor do
  let(:supervisor) { FactoryGirl.build(:supervisor) }

  subject { supervisor }

  it { should respond_to(:research_centre) }

  it { should validate_presence_of(:research_centre) }

  it { should belong_to(:research_centre) }

end
