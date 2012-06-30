require 'spec_helper'

describe Course do
  
  before(:each) do
    @degree_scheme = FactoryGirl.create(:degree_scheme)
    @course = FactoryGirl.create(:course)    
  end
  
  it "should have a route code" do
    @course.route_code.should == 'XMECS'
  end
  
  it "should have a route name" do
    @course.route_name.should == 'Mechanical Engineering Single'    
  end
  
  it "should have a title" do
    @course.title.should == 'Mechanical Engineering'
  end
  
  it "should have a university course title" do
    @course.university_course_title.should == 'Mechanical Engineering 3yr FULL TIME'    
  end

  it "should have a degree field" do
    @course.degree.should == 'BEng'    
  end

  it "should validate uniqueness of route code" do
    course = FactoryGirl.build(:course, route_code: @course.route_code)
    course.should_not be_valid
    course.errors_on(:route_code).should include "is already taken"
    other_course = FactoryGirl.build(:course, route_code: '4CEHS').should be_valid
  end
  
  it "should belong to a degree sceheme" do
    @course.degree_scheme = @degree_scheme
    @course.save!
    @course.reload
    @course.degree_scheme.should == @degree_scheme
    @degree_scheme.courses.should include @course
  end
end