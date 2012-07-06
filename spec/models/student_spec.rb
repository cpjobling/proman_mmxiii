require 'spec_helper'

describe Student do

  let(:student) { FactoryGirl.build(:student) }

  subject { student }

  it { should respond_to(:discipline) }
  it { should respond_to(:course) }
  it { should respond_to(:grade) }
  it { should respond_to(:progression) }
  it { should respond_to(:level_last_year) }
  it { should respond_to(:supp_count) }
  it { should respond_to(:comments) }

  it { should validate_presence_of(:discipline) }
  it { should validate_presence_of(:course) }

  it { should belong_to(:discipline) }
end
