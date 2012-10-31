require "cancan/matchers"
# ...
describe "Guest"

describe "User" do
  describe "abilities" do
    subject { ability }
    let(:ability){ Ability.new(user) }

    context "when is a guest" do
      let(:user){ FactoryGirl.create(:user) }

      it { should be_able_to(:read, Project.new) }
      it { should_not be_able_to(:create, Project.new) }
      it { should_not be_able_to(:update, Project.new) }
      it { should_not be_able_to(:destroy, Project.new) }
    end

    context "when is a supervisor" do
      it "should be able to manage own projects"
    end

    context "when is a student" do
      it "should be able to read projects"
    end

    context "when is a coordinator" do
      it "should be able to manage projects"
    end

    context "when is a administrator" do
      let(:user){ FactoryGirl.create(:admin_user) }

      it { should be_able_to(:manage, :all) }
    end
  end
end
