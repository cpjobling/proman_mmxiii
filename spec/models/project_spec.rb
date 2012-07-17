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
  it { should respond_to(:research_centre_name)}
  it { should respond_to(:research_centre_code)}
  it { should respond_to(:allocated)}

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
end