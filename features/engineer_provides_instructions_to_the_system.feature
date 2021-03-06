Feature: Engineer provides instructions to the system

  As a NASA Engineer
  I want to be able to specify an instructions file for the system to process and then have the system process those instructions
  In order to easily input a predefined set of instructions into the system and get the rovers moving 
  
  Scenario: Provide the system with instructions 
    Given I have started the system
    When I provide a instruction file called 'instructions/input1.txt'
    Then the system should read in the file and have it ready for processing
    And the system should process the file and move the rover at start position '3 3 E'
    And display the final position of the rover to the screen as '5 1 E'
    
#    Scenarios: Rover positions
#    | start position | final position |
#    | '1 2 N'        | '1 3 N'        |
#    | '3 3 E'        | '5 1 E'        |


