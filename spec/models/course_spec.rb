require 'spec_helper'

describe Course do
  
  let (:degree_scheme) { FactoryGirl.create(:degree_scheme) }
  let (:course) { FactoryGirl.create(:course)  }

  subject { course }
  
  # API
  it { should respond_to(:route_code) }
  it { should respond_to(:route_name) }
  it { should respond_to(:university_course_title) }
  it { should respond_to(:degree) }
  it { should respond_to(:title) }

  # Associations
  it { should belong_to(:degree_scheme) }
 
  # Validations
  it { should validate_uniqueness_of(:route_code).case_insensitive }
  it { should validate_presence_of(:degree) }
  it { should validate_presence_of(:title) }
 
  # Property readers
  its(:route_code)              { should == 'XMECS' }
  its(:route_name)              { should == 'Mechanical Engineering Single' }    
  its(:title)                   { should == 'Mechanical Engineering' }
  its(:university_course_title) { should == 'Mechanical Engineering 3yr FULL TIME' }  
  its(:degree)                  { should == 'BEng' }   

  it { should have_index_for(:route_code).with_options(unique: true) } 

end