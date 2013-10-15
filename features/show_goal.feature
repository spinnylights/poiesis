Feature: Show current goal
  In order to know what I'm working towards
  I want to view the goal of time worked and deadline

  Scenario: No goal is currently set
    When I run `poiesis set goal --none`
    And  I run `poiesis show goal`
    Then the stdout from "poiesis show goal" should contain "No goal is set."

  Scenario: A goal is set
    When I run `poiesis set goal 10 01/01/2040`
    And  I run `poiesis show goal`
    Then the stdout from "poiesis show goal" should contain "10 hours of work by January 1st, 2040."
