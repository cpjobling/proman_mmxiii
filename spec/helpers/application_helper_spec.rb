require 'spec_helper'

describe ApplicationHelper do

  describe "full_title" do
    it "should include the page title" do
      full_title("foo").should =~ /foo/
    end

    it "should include the base title" do
      full_title("foo").should =~ /^Proman 2013/
    end

    it "should not include a bar for the home page" do
      full_title("").should_not =~ /\|/
    end
  end

  describe "yesno" do
    it "should return 'Yes' for true" do
      yesno(true).should eql("Yes")
    end
    it "should return 'No' for false" do
      yesno(false).should eql("No")
    end
  end

  describe "logo" do
    it "should return the Proman logo" do
      logo.should eql(raw "Proman<em><sup>mmxiii</sup></em>")
    end
  end

  describe "proman" do
    it "should return Proman" do
      proman.should eql("Proman")
    end
  end
end