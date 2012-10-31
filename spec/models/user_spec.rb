require 'spec_helper'
require "cancan/matchers"


describe User do

  before(:each) do
    @user = User.new(
      @attr = {
        # :name => "Example User",
        :email => "user@example.com",
        :password => "foobar",
        :password_confirmation => "foobar"
      }
    )
  end

  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject duplicate staff or student numbers" do
    @attr[:email] = 'user2@example.com'
    User.create!(@attr)
    user_with_duplicate_ssn= User.new(@attr)
    user_with_duplicate_ssn.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

  end

  describe "Normal user operations" do
    subject { @user }

    it { should respond_to(:email)}
    it { should respond_to(:password)}
    it { should respond_to(:password_confirmation)}
    it { should respond_to(:remember_me)}
    it { should have_index_for(:email).with_options(unique: true) }
  end

  describe "Role model" do
    before(:each) do
      @user = User.create!(@attr)
    end

    subject { @user }

    it { should respond_to :guest? }  
    it { should respond_to :admin? }  
    it { should respond_to :roles }
    it { should respond_to :has_role? }
    it { should respond_to :has_any_role? }
    it { should respond_to :has_all_roles? }
    it { should respond_to :is? }
    it { should respond_to :authentication_token }

    it "should respond to valid roles" do
      User.valid_roles.class.should == Array
    end

    it "should support expected application roles" do
      [:admin, :coordinator, :supervisor, :student].each do |role|
        User.valid_roles.should include(role)
      end
    end

    it "should have no roles on create" do
      @user.roles.should be_blank
    end

    it "should have guest role on create" do
      @user.guest?.should == true
    end

    it "should be possible to add valid roles" do
      User.valid_roles.each do |role|
        @user.roles << role
        @user.should have_role role
      end
    end

    it "should not be possible to add invalid roles" do
      @user.roles << :invalid_role
      @user.should_not have_role :invalid_role
    end

    it "should be possible to delete roles" do
      User.valid_roles.each do |role|
        @user.roles << role
        @user.should have_role role
        @user.roles.delete role
        @user.should_not have_role role
      end
    end

    it "should be possible for a user to have multiple roles" do
      my_roles = []
      User.valid_roles.each do |role|
        @user.roles << role
        my_roles << role
        @user.should have_roles my_roles
      end
    end

    it "should be possible to query a role" do
      User.valid_roles.each do |role|
        @user.roles << role
        @user.should have_role role
      end
    end

    it "should be possible to test a subset of roles" do
      test_roles = [:coordinator, :supervisor]
      User.valid_roles.each do |role|
        @user.roles << role
      end
      @user.has_any_role?(test_roles[0]).should be_true
      @user.has_any_role?(test_roles[1]).should be_true
      @user.has_any_role?(test_roles).should be_true
      @user.roles.delete :supervisor
      @user.has_any_role?(test_roles).should be_true
      @user.roles.delete :coordinator
      @user.has_any_role?(test_roles).should be_false
    end

    describe "admin role" do
      before(:each) do 
        @user.roles << :admin
        @user.save!
        @admin = @user
      end

      subject { @admin }

      its(:admin?) { should be_true }
    end
  end
end
