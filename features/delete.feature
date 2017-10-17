Feature: delete user
As an admin, I want to be able to validate a user

Scenario: Admin can delete a user
  Given I am an admin
  And I am on the users page
  When I delete a user
  Then the user is deleted