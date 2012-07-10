Feature: Projects by discipline
  In order to show projects available for a given discipline
  As a student
  I should be able to view projects for my discipline

    Scenario: view projects by discipline
      Given I am not logged in
      When I visit the page of projects for a discipline
      Then I should see only projects in the discipline
        And I should not see projects in another discipline

