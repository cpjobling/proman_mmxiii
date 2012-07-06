require 'spec_helper'

describe ResearchCentre do
  it { should respond_to(:code) }
  it { should respond_to(:title) }

  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:title) }

  it { should validate_uniqueness_of(:code).case_insensitive }
  it { should validate_uniqueness_of(:title).case_insensitive }

  it { should have_index_for(:code).with_options(unique: true) }

  it { should have_many(:supervisors) }
end
