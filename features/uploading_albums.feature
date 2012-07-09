Feature: Uploading albums
  @wip
  Scenario: Uploading an album
    Given I am logged in
    When I upload an album "A Love Supreme" by "John Coltrane"
    Then I should have an album "A Love Supreme" by "John Coltrane"
