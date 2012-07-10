require 'spec_helper'

describe Discipline do

  it { should respond_to(:code) }
  it { should respond_to(:name) }

  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:name) }

  it { should validate_uniqueness_of(:code).case_insensitive }
  it { should validate_uniqueness_of(:name).case_insensitive }

  it { should have_index_for(:code).with_options(unique: true) }
  it { should have_index_for(:name).with_options(unique: true) }

  it { should have_many(:students) }
  it { should have_many(:projects) }

end
