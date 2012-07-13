def create_two_users
  @project1 = FactoryGirl.create(:project, title: 'First demo project')
  @project1 = FactoryGirl.create(:project, title: 'Second demo project', available: false)
end

When /^I visit the projects page$/ do
  create_two_users
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
  page.should have_content @project1.code
  page.should have_content @project1.title
  save_and_open_page
  page.should have_content 'Not available'
end
