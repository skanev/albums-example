Feature: Authentication
  Scenario: Logging in
    Given a user "john.doe@example.org" with password "secret"
    When I attempt to log in with email "john.doe@example.org" and password "secret"
    Then I should be logged in
