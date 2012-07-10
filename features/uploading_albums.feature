Feature: Uploading albums
  Background:
    Given I am logged in

  Scenario: Uploading an album
    When I upload an album "A Love Supreme" by "John Coltrane"
    Then I should have an album "A Love Supreme" by "John Coltrane"

  Scenario: Submitting an invalid album form
    When I attempt to upload an invalid album
    Then I should see that my album is invalid

  Scenario: Edit an album
    Given I have an album "A Love Supreme" by "John Coltrane"
    When I edit "A Love Supreme" and change:
      | Name   | Waltz for Debby   |
      | Artist | Monica Zetterlund |
    Then I should have an album "Waltz for Debby" by "Monica Zetterlund"
