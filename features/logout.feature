Feature: logout
As a user, I want to be able to logout of my account

Scenario: User can logout to their account
  Given I am logged in
  When I logout
  Then I am logged out