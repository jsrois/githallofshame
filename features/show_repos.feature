Feature: ShowRepos
  
  Background: 
    Given that I am at the main page
    
  Scenario: Display existing repositories in main page
    Then I should see the "Foo" repository in the list
    And I should see the "Bar" repository in the list
    
  Scenario: Displaying the "Top 10" pieces of crap
    When I click at the "Top10" button
    Then I should see the Top10 title on the page
    And only the crappiest 10 repositories should be on the list
    
  Scenario: Back to the main list
    When I click at the "Top10" button
    And Then I click at the "All" button
    Then I should be back at the main page