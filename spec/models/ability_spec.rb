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

    context "when is a supervisor"

    context "when is a student"

    context "when is a coordinator"

    context "when is a administrator" do
      let(:user){ FactoryGirl.create(:admin) }

      it { should be_able_to(:manage, :all) }
    end
  end
end
