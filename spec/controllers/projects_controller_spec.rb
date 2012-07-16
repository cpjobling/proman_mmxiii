require 'spec_helper'



describe ProjectsController do

  before(:each) do
    discipline = Discipline.create!(code: "mech", name: "Mechanical Engineering")
    @project = FactoryGirl.create(:project, discipline: discipline)   
  end

  describe "GET 'projects#index'" do
    before(:each) do
      get :index
    end
    it "returns http success" do
      response.should be_success
    end
    it "assigns @projects" do
      assigns(:projects).should eq([@project])
    end
    it "renders the index template" do
      response.should render_template("index")
    end
  end

  describe "GET 'project#show[:id]'" do
    before(:each) do
      puts "@project=#{@project}"
      get :show, id: @project
    end
    it "returns http success" do
      response.should be_success
    end
    it "assigns the requested project to @project" do
      assigns(:project).should eq(@project)
    end
    it "renders the show template" do
      response.should render_template("show")
    end
  end

  describe "GET 'projects#by_discipline[:discipline]'" do
    it "returns http success" do
      get :by_discipline, discipline: "mech"
      response.should be_success
    end
  end

end
