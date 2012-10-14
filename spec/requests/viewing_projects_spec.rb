require 'spec_helper'

feature "Viewing Projects" do
  scenario "Listing projects" do
    project = Factory.create(:project, :title => "Build a gizmo")
    visit "/"
    click_link 'Build a gizmo'

    page.current_url.should == project_url(project)
  end
end
