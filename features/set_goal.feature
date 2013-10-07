Feature: Manipulating the current goal
  In order to track my progress towards a goal
  I want to tell poiesis what my goal is
  So that it can remember for me

  Scenario: Setting a new goal
    When I run `poiesis set goal 20 3/2/2020`
    Then the output should contain "Your new goal is 20 hours of work by March 2nd, 2020."
    When I run `poiesis set goal 40 6/5/2070`
    Then the output should contain "Your new goal is 40 hours of work by June 5th, 2070."

  Scenario: Setting the goal to none
    When I run `poiesis set goal --none`
    Then the output should contain "Now there is no goal."
