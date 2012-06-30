require 'spec_helper'

describe DegreeScheme do
  
  before(:each) do
    @degree_scheme = FactoryGirl.create(:degree_scheme)
  end
  
  it "should have a programme code" do
    @degree_scheme.program_code.should == "BEHE3XX"
  end
  
  it "should have a course title" do
    @degree_scheme.course_title.should == "Bachelor of Engineering (Hons)"
  end
  
  it "is not valid without a programme code" do
    meng = FactoryGirl.build(:degree_scheme, program_code: nil, course_title: 'Bachelor of Engineering (Hons)')
    meng.should_not be_valid
    meng.errors_on(:program_code).should include "can't be blank"
  end
  
  it "is not valid without a course title" do
    meng = FactoryGirl.build(:degree_scheme, program_code: 'MEHE4XX', course_title: nil)
    meng.should_not be_valid
    meng.errors_on(:course_title).should include "can't be blank"    
  end
  
  it "should have many courses" do
    mech_eng = FactoryGirl.create(:course)
    mech_eng.degree_scheme = @degree_scheme
    mech_eng.save!
    mech_eng.reload
    chem_eng = FactoryGirl.create(:course,
      route_code: 'XEGBS', route_name: 'Chemical and Bioprocess Engineering Single', 
      degree: 'BEng', title: 'Chemical and Bioprocess Engineering', 
      university_course_title: 'Chemical and Bioprocess Engineering 3yr FULL TIME')
    chem_eng.degree_scheme = @degree_scheme
    chem_eng.save!
    chem_eng.reload
    @degree_scheme.courses.length.should == 2
    @degree_scheme.courses.should include mech_eng
    @degree_scheme.courses.should include chem_eng
  end
  
  it "should validate uniqueness of program code" do
    ds = FactoryGirl.build(:degree_scheme, program_code: @degree_scheme.program_code)
    ds.should_not be_valid
    ds.errors_on(:program_code).should include "is already taken"
    other_course = FactoryGirl.build(:degree_scheme, program_code: 'MEHE4XX').should be_valid
  end
  
end