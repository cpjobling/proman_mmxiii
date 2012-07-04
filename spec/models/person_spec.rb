require 'spec_helper'

describe Person do

  let(:charlie) { FactoryGirl.build(:person)  }

  subject { charlie } 

  # Fields
  it { should respond_to(:title)}
  it { should respond_to(:forename1)}
  it { should respond_to(:forename2)}
  it { should respond_to(:forename3)}
  it { should respond_to(:preferred_name)}
  it { should respond_to(:surname)}
  it { should respond_to(:date_of_birth)}

  # Dynamic fields
  it { should respond_to(:name)}
  it { should respond_to(:full_name)}
  it { should respond_to(:sortable_name)}
  it { should respond_to(:formal_address)}

  it { should be_valid }


  describe "validations" do

    context "when title is not present" do
      before { charlie.title = " " }
      it { should_not be_valid }
    end
  
    context "when there is no first forename" do
      before { charlie.forename1 = " " }
      it { should_not be_valid }
    end
 
    context "when there is no surname" do
      before { charlie.surname = " " }
      it { should_not be_valid }
    end

    context "when there is a date of birth" do
      context "the date of birth is invalid" do
        before { charlie.date_of_birth = "rubbish" }
        it { should_not be_valid }
        it "should give invalid error message" do
          charlie.errors_on(:date_of_birth).should include("should match dd/mm/yyyy") 
        end
      end
      context "the date of birth is valid" do
        before { charlie.date_of_birth = '14/11/1948'}
        it { should be_valid }
      end
    end
  end

  describe "forenames" do
    context "no forename" do
      before { charlie.forename1 = " " }
      its(:forename1) { should be_blank }
      it { should_not be_valid }
    end
  
    context "two forenames" do
      before { charlie.forename3 = " " }
      it { should be_valid }
      its(:full_name)   { should == "Mr Charles Philip Windsor" }
      its(:sortable_name) { should == "Windsor, Charles Philip" }
    end
  
    context "three forenames" do
      its(:forename1)     { should == "Charles" }
      its(:forename2)     { should == "Philip" }
      its(:forename3)     { should == "Arthur George" }
      its(:full_name)     { should == "Mr Charles Philip Arthur George Windsor" }
      its(:sortable_name) { should == "Windsor, Charles Philip Arthur George" }
    end
  end
  
  
  describe "preferred name used in pereference to first forename" do
    context "blank preferred preferred_name" do
      before { charlie.preferred_name = " " }
      it { should be_valid }
      its (:preferred_name) { should be_blank }
      its (:name)           { should == "Charles" }
    end

    context "non-blank preferred name" do
     it { should be_valid }
      its(:name) { :should == "Chuck" }
    end
  end
  
  describe "full_name" do
    its(:full_name) {should == "Mr Charles Philip Arthur George Windsor" }
  end
  
  describe "sortable_name" do
    its(:sortable_name) { should == "Windsor, Charles Philip Arthur George" }
  end
  
  describe "formal_address" do
    its(:formal_address) { should == "Mr Windsor" }
  end
  
  describe "date_of_birth" do
    context "blank" do
      its(:date_of_birth) { should be_blank }
    end
    
    context "date of birth set" do
      before { charlie.date_of_birth = '14/11/1948' }
      its(:date_of_birth)  { should == '14/11/1948' }
    end
  end
  
end
