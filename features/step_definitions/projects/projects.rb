def create_supervisor
  @supervsr ||= FactoryGirl.create(:supervisor)
end

def create_two_projects
  @project1 = FactoryGirl.create(:project, title: 'First demo project', supervisor: create_supervisor)
  @project2 = FactoryGirl.create(:project, title: 'Second demo project', supervisor: create_supervisor, available: false)
end

When /^I visit the projects page$/ do
  create_two_projects
  visit '/projects'
end

Then /^I should see "(.*?)" in the page content$/ do |title|
  page.should have_content "Projects"
end

Then /^I should see a list of available projects$/ do
  page.should have_content @project1.code
  page.should have_content @project1.title
  page.should have_content 'Available'
end

Then /^I should also see projects that are not available$/ do
  page.should have_selector 'tr td a', text: 'p-2012-002'
  page.should have_content @project2.code
  page.should have_content @project2.title
  page.should have_content 'Not available'
end

When /^I follow a link to a project$/ do
  click_link @project1.code
  save_and_open_page
end

Then /^I should see project code and decription in the header$/ do
  page.should have_selector "article##{@project1.code}"
  page.should have_selector "header h1", text: /^#{@project1.code}.*#{@project1.title}$/
end

Then /^I should see the supervisors details$/ do
  page.should have_content @project1.supervisor_name
  page.should have_content @project1.supervisor_email
  page.should have_content @project1.research_centre_code
  page.should have_content @project1.research_centre_name
end

Then /^I should see the public project details$/ do
  page.should have_content @project1.status
  # + should contain description
end

