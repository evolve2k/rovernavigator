Feature: Engineer starts up the Navigation System

  As an NASA Engineer
  I want to start the navigation system
  In order to begin to navigate with my rovers
  
Scenario: Start navigation system
  Given I have not yet entered any navigation instructions
  When I start the navigation system
  Then I should see "--< Welcome to the NASA Mars Rover Navigation Console >--"
  And I should see "First define size of plateu (grid area)"
  And I should see "Enter Plateu Size (eg for 5x5 type '5 5'):"
