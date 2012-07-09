Feature: Registration
  Scenario: Registering a new account
    When I register an account
    Then I should be logged in
