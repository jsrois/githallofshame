Feature: ShowRepos
  
  Scenario: Display existing repositories in main page
    Given that I am at the main page
    Then I should see the "Foo" repository in the list
    And I should see the "Bar" repository in the list