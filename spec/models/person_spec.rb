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
  it { should respond_to(:informal_name)}
  it { should respond_to(:sortable_informal_name)}
  it { should respond_to(:sortable_name_and_title)}
  it { should respond_to(:sortable_informal_name_and_title)}

  it { should be_valid }

  # Validations

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:forename1) }
  it { should validate_presence_of(:surname) }
  it { should validate_format_of(:date_of_birth)
          .to_allow("14/11/1948")
          .not_to_allow("rubbish")}

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
      its(:sortable_name_and_title) { should == "Windsor, Mr Charles Philip" }
    end
  
    context "three forenames" do
      its(:forename1)     { should == "Charles" }
      its(:forename2)     { should == "Philip" }
      its(:forename3)     { should == "Arthur George" }
      its(:full_name)     { should == "Mr Charles Philip Arthur George Windsor" }
      its(:sortable_name) { should == "Windsor, Charles Philip Arthur George" }
      its(:sortable_name_and_title) { should == "Windsor, Mr Charles Philip Arthur George" }
    end
  end
  
  
  describe "preferred name used in preference to first forename" do
    context "blank preferred preferred_name" do
      before { charlie.preferred_name = " " }
      it { should be_valid }
      its (:preferred_name)                    { should be_blank }
      its (:name)                              { should == "Charles" }
      its (:informal_name)                     { should == "Charles Windsor"}
      its (:sortable_informal_name)            { should == "Windsor, Charles"}
      its (:sortable_informal_name_and_title)  { should == "Windsor, Mr Charles"}
    end

    context "non-blank preferred name" do
     it { should be_valid }
      its (:name)                              { should == "Chuck" }
      its (:informal_name)                     { should == "Chuck Windsor"}
      its (:sortable_informal_name)            { should == "Windsor, Chuck"}
      its (:sortable_informal_name_and_title)  { should == "Windsor, Mr Chuck"}
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
