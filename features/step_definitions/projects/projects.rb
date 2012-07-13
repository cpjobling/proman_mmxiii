def create_supervisor
  @supervsr ||= Supervisor.create!(
    password: "please",
    confirm_password: "please",
    staff_number: 123457,
    bbusername: "bbuname",
    email: "super@swanseaa.ac.uk",
    title: "Prof",
    forename1: "Albert",
    surname: "Einstein",
    confirmed_at: Time.now
  )
end
def create_two_projects
  @project1 = FactoryGirl.create(:project, title: 'First demo project', supervisor: create_supervisor)
  @project1 = FactoryGirl.create(:project, title: 'Second demo project', supervisor: create_supervisor, available: false)
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
  page.should have_content @project1.code
  page.should have_content @project1.title
  save_and_open_page
  page.should have_content 'Not available'
end
