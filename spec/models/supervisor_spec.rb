require 'spec_helper'

describe Supervisor do
  let(:supervisor) { FactoryGirl.build(:supervisor) }

  subject { supervisor }

  it { should respond_to(:staff_number)}

  it { should respond_to(:bbusername)}

  it { should respond_to(:research_centre) }

  it { should validate_presence_of(:staff_number) }

  it { should validate_presence_of(:bbusername) }

  it { should belong_to(:research_centre) }

  it { should have_many(:projects)}

  it { should validate_uniqueness_of(:bbusername) }

  it { should validate_uniqueness_of(:staff_number) }

  it { should have_index_for(:staff_number).with_options(unique: true)}

  it { should have_index_for(:bbusername).with_options(unique: true)}

end
