require 'spec_helper'

describe Student do

  let(:student) { FactoryGirl.build(:student) }

  subject { student }
  it { should respond_to(:student_number)}
  it { should respond_to(:discipline) }
  it { should respond_to(:course) }
  it { should respond_to(:grade) }
  it { should respond_to(:progression) }
  it { should respond_to(:level_last_year) }
  it { should respond_to(:supp_count) }
  it { should respond_to(:comments) }

  it { should validate_presence_of(:discipline) }
  it { should validate_presence_of(:course) }
  it { should validate_presence_of(:student_number) }

  it { should validate_uniqueness_of(:student_number)}

  it { should belong_to(:discipline) }

  it { should have_index_for(:student_number).with_options(unique: true) }
end
