Feature: Log time worked
  In order to track my progress towards my goal
  I want to record time I have worked

@wip
  Scenario: Made progress
    When I run `poiesis set goal 20 2/5/2038`
    And  I run `poiesis log 8:34`
    Then the output from "poiesis log 8:34" should contain "Logged 8 hours and 34 minutes of work."
    When  I run `poiesis show progress`
    Then the output from "poiesis show progress" should contain "You have 11 hours and 26 minutes of work to complete by February 5th, 2038."

@wip
  Scenario: Log twice
    When I run `poiesis set goal 20 3/30/2032`
    And  I run `poiesis log 9:00`
    And  I run `poiesis log 2:00`
    And  I run `poiesis show progress`
    Then the output from "poiesis show progress" should contain "You have 9 hours of work to complete by March 30th, 2032."

  Scenario: Reached goal
    When I run `poiesis set goal 5 3/2/2020`
    And  I run `poiesis log 5`
    Then the output from "poiesis log 5" should contain "You met your goal!"
    When I run `poiesis show goal`
    Then the output from "poiesis show goal" should contain "No goal is set."
