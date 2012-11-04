require 'spec_helper'

feature "Viewing Projects" do
  scenario "Listing projects" do
    project = FactoryGirl.create(:project, :title => "Build a gizmo")
    visit projects_path
    click_link 'Build a gizmo'

    page.current_url.should == project_url(project)
  end
end
