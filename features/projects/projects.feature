Feature: Projects
  In order to show projects available
  As a visitor
  I should be able to view projects

    Scenario: list projects all
      Given I am not logged in
      When I visit the projects page
      Then I should see "Projects" in the page content
      And I should see a list of available projects
        And I should also see projects that are not available

    Scenario: show a particular project
      Given I am not logged in
      When I visit the projects page
      And I follow a link to a project
      Then I should see project code and decription in the header
        And I should see the supervisors details
        And I should see the project description
        And I should see the other public project details
        And I should not see any priveleged project details


