Feature: Searching albums
  Scenario: Searching albums
    Given I am logged in
    And I have the following albums:
      | Name            | Artist        |
      | A Love Supreme  | John Coltrane |
      | Waltz for Debby | Bill Evans    |
      | Love Songs      | Miles Davis   |
    When I search my albums for "love"
    Then I should have found "A Love Supreme" by "John Coltrane"
    And I should have found "Love Songs" by "Miles Davis"
    But I should have not found "Waltz for Debby" by "Bill Evans"
