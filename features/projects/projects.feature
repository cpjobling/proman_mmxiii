Feature: Projects
  In order to show projects available
  As a visitor
  I should be able to view projects

    Scenario: list projects
      Given I am not logged in
      When I visit the projects page
      Then I should see "Projects" in the page content
      And I should see a list of available projects
        And I should also see projects that are not available

