Feature: login
As a user, I want to be able to login so that I can view my details

Scenario: User can login to their account
  Given I am on the login page
  When I login
  Then I am taken to my profile
