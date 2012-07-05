require 'spec_helper'

describe DegreeScheme do

  let(:beng) { FactoryGirl.create(:degree_scheme) }

  subject { beng }

  # API
  it { should respond_to(:program_code) }
  it { should respond_to(:course_title) }
  it { should respond_to(:courses) }

  it { should be_valid }

  # Values
  its(:program_code) { should == "BEHE3XX" }
  its(:course_title) { should == "Bachelor of Engineering (Hons)" }
  
  # Validations
  it { should validate_presence_of(:program_code) }
  it { should validate_presence_of(:course_title) }
  it { should validate_uniqueness_of(:program_code).case_insensitive }
 
  # Associations
  it { should have_many(:courses) }

  it { should have_index_for(:program_code).with_options(unique: true) } 
end