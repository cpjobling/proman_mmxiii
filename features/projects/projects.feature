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
        And I should see all project codes as ids

    Scenario: show a particular project
      Given I am not logged in
      When I visit the projects page
      And I follow a link to a project
      Then I should see project code and decription in the header
        And I should see the supervisors details
        And I should see the intended discipline
        And I should see the project description
        And I should see the other public project details
        And I should see a link back to projects page for this project
        And I should not see any privileged project details

    Scenario: dealing with student defined projects
       Given there is a student-defined project
       And I am not logged in
       When I visit the projects page
        And I follow a link to a project
         Then I should see that the project has been defined by a student
         And I should see the student's number
         But I should not see the student's name
         And I should not see the student's email address

    Scenario: list projects by discipline
      Given I am not logged in
      When I visit a projects by discipline page
      Then I should see "Projects for a discipline" in the page content
      And I should see a list of available projects
        And I should also see projects that are not available
        And I should see all project codes as ids

    Scenario: show a particular project by discipline
      Given I am not logged in
      When I visit a projects by discipline page
      And I follow a link to a project
      Then I should see project code and decription in the header
      And I should see the supervisors details
        And I should see the intended discipline
        And I should see the project description
        And I should see the other public project details
        And I should see a link back to projects page for this project
        And I should not see any privileged project details

   
