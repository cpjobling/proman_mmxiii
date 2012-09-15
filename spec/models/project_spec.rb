require 'spec_helper'

describe Project do

  let(:project) { FactoryGirl.create(:project) }

  subject { project }

  it { should respond_to(:code)}
  it { should respond_to(:title)}
  it { should respond_to(:discipline)}
  it { should respond_to(:description)}
  it { should respond_to(:associated_with)}
  it { should respond_to(:cross_disciplinary_theme)}
  it { should respond_to(:students_own_project?)}
  it { should respond_to(:student_number)}
  it { should respond_to(:student_name)}
  it { should respond_to(:available?)}
  it { should respond_to(:special_requirements)}
  it { should respond_to(:research_centre)}
  it { should respond_to(:status)}
  it { should respond_to(:supervisor_email)}
  it { should respond_to(:supervisor_name)}
  it { should respond_to(:supervisor_sortable_name)}
  it { should respond_to(:supervisor_sortable_name_and_title)}
  it { should respond_to(:research_centre_name)}
  it { should respond_to(:research_centre_code)}
  it { should respond_to(:allocated?)}
  it { should respond_to(:allocate_to)}
  it { should respond_to(:allocated_to)}
  it { should respond_to(:deallocate)}
  it { should respond_to(:make_unavailable)}
  it { should respond_to(:make_available)}

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:discipline) }
  it { should validate_presence_of(:supervisor) }

  # it { should_not respond_to(:available)}
  # it { should_not respond_to(:students_own_project)}

  it { should belong_to(:discipline)}
  it { should belong_to(:supervisor)}

  # Supervisor properties
  its(:supervisor)            { should == project.supervisor }
  its(:supervisor_email)      { should == project.supervisor.email }
  its(:supervisor_name)       { should == project.supervisor.full_name }
  its(:research_centre)       { should == project.supervisor.research_centre }
  its(:research_centre_name)  { should == project.supervisor.research_centre_name }
  its(:research_centre_code)  { should == project.supervisor.research_centre_code }
  its(:status)                { should == "Available" }

  it "should implement Project.by_id" do
    Project.by_id(project.pid).should eq(project)
  end

end

describe "project allocation" do
    let(:project) { FactoryGirl.create(:project) }

    subject { project }
    
    before(:each) do
      project.allocate_to(123456,"Other, Anthony Norman")
      project.reload
    end

    it{ should be_allocated }
    its (:allocated_to) { should == {number: 123456, name: "Other, Anthony Norman"} }
    it { should_not be_available }
    its (:status) { should == "Allocated to 123456" }
end

describe "project deallocation" do
    let(:allocated_project) { FactoryGirl.create(:project, 
                      allocated: true, student_number: 123456, student_name: "Other, Anthony Norman") }
    let(:own_project) { FactoryGirl.create(:project, 
                      allocated: true, student_number: 123456, student_name: "Other, Anthony Norman", 
                      students_own_project: true) }

    subject { allocated_project }

    it { should be_allocated }
    its (:allocated_to) { should == {number: 123456, name: "Other, Anthony Norman"} }
    it { should_not be_available }
    its (:status) { should == "Allocated to 123456" }

    describe "deallocation" do
      before(:each) do
        allocated_project.deallocate
      end
      it "should be deallocated" do
        allocated_project.allocated?.should be_false
      end
      it "should not have a student number" do
        allocated_project.student_number.should be_nil
      end
      it "should not have a student name" do
        allocated_project.student_name.should be_nil
      end
      it "should be available" do
        allocated_project.available?.should be_true
      end
      it "should have 'available' status" do
        allocated_project.status.should == "Available"
      end
    end

    describe "deallocation of a students own project" do
      before(:each) do
        own_project.deallocate
      end
      it "should still be students_own_project" do
        own_project.students_own_project?.should be_true
      end
      it "should be deallocated" do
        own_project.allocated?.should be_false
      end
      it "should still have a student number" do
        own_project.student_number.should == 123456
      end
      it "should still have a student name" do
        own_project.student_name.should == "Other, Anthony Norman"
      end
      it "should be available" do
        own_project.available?.should be_true
      end
      it "should have 'available' status" do
        own_project.status.should == "Available"
      end
    end

end

describe "project available flag" do

  let(:available_project) { FactoryGirl.create(:project) }
  let(:unavailable_project) { FactoryGirl.create(:project, available: false) }

  subject { available_project }

  it {should be_available }
  its(:available) { should be_true }

  describe "available_project#make_unavailable" do

    before(:each) do
      available_project.make_unavailable
    end

    its(:available) { should be_false }
    it { should_not be_available }
    its(:status) { should == "Not available" }
  end

  describe "unavailable_project#make_available" do

    before(:each) do
      unavailable_project.make_available
    end

    it "should be available" do
      unavailable_project.available.should be_true
      unavailable_project.should be_available
      unavailable_project.status.should == "Available"
    end
  end

end

describe "project#change_discipline" do
  let (:old_discipline) { FactoryGirl.create(:discipline) }
  let (:new_discipline) { FactoryGirl.create(:discipline) }
  let (:project) { FactoryGirl.build(:project, discipline: old_discipline )}

  subject { project }

  it "should be set up correctly" do
    old_discipline.should_not be_nil
    new_discipline.should_not be_nil
  end

  its(:discipline) { should_not be_nil}
  its(:discipline) { should == old_discipline }

  
  it "should do nothing if code is blank or nil" do
    project.change_discipline('')
    project.discipline.should == old_discipline
    project.change_discipline(nil)
    project.discipline.should == old_discipline
  end

  it "should do nothing if no discipline exists for code" do
    project.change_discipline('rubbish')
    project.discipline.should == old_discipline
  end

  it "should change discipline" do
    project.change_discipline(new_discipline.code)
    project.discipline.should == new_discipline
  end

  it "should not change discipline if allocated" do
    project.allocated = true
    project.change_discipline(new_discipline.code)
    project.discipline.should == old_discipline
  end

  it "should not change discipline if students_own project" do
    project.students_own_project = true
    project.change_discipline(new_discipline.code)
    project.discipline.should == old_discipline
  end
end


