require 'spec_helper'

describe Course do
  
  before(:each) do
    @degree_scheme = FactoryGirl.create(:degree_scheme)
    @course = FactoryGirl.create(:course)    
  end
  
  it "has a route code" do
    @course.route_code.should == 'XMECS'
  end
  
  it "has a route name" do
    @course.route_name.should == 'Mechanical Engineering Single'    
  end
  
  it "has a title" do
    @course.title.should == 'Mechanical Engineering'
  end
  
  it "has a university course title" do
    @course.university_course_title.should == 'Mechanical Engineering 3yr FULL TIME'    
  end

  it "has a degree field" do
    @course.degree.should == 'BEng'    
  end

  it "is not valid without a unique route code" do
    course = FactoryGirl.build(:course, route_code: @course.route_code)
    course.should_not be_valid
    course.errors_on(:route_code).should include "is already taken"
    other_course = FactoryGirl.build(:course, route_code: '4CEHS').should be_valid
  end
  
  it "is not valid without a degree field" do
    @course.degree = nil
    @course.should_not be_valid
    @course.errors_on(:degree).should include "can't be blank"
  end
  
  it "is not valid without a title" do
    @course.title = nil
    @course.should_not be_valid
    @course.errors_on(:title).should include "can't be blank"
  end
  
  it "belongs to a degree sceheme" do
    @course.degree_scheme = @degree_scheme
    @course.save!
    @course.reload
    @course.degree_scheme.should == @degree_scheme
    @degree_scheme.courses.should include @course
  end
end