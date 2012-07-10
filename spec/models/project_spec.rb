require 'spec_helper'

describe Project do

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

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:discipline) }
  it { should validate_presence_of(:supervisor) }
  # it { should_not respond_to(:available)}
  # it { should_not respond_to(:students_own_project)}

  it { should belong_to(:discipline)}
  it { should belong_to(:supervisor)}

end