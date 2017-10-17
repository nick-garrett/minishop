Feature: validate user
As an admin, I want to be able to validate a user

Scenario: Admin can validate a user
  Given I am an admin
  And I am on the users page
  When I validate a user
  Then the user is validated