Feature: Moving a rover around a plateu

To control a rover, NASA sends a simple string of letters. 
The possible letters are 'L', 'R' and 'M'. 
'L' and 'R' makes the rover spin 90 degrees left or right respectively, without moving from its current spot.
'M' means move forward one grid point, and maintain the same heading.

In order for the NASA rovers to get a complete view of the surrounding terrain to send back to Earth
As a NASA Engineer
I want to be able to send commands so I can navigate a rover around the plateu

 Scenario: Moving a rover
   Given I have a plateu 
   And the plateu is 5 units long by 5 units wide
   And a I have a rover at position 1,2 facing "North"
   When I give the rover the instructions "LMLMLMLMM"
   Then the rover should move until it reaches the position 1,3 

 Scenario: Provide the system with invalid instructions
   Given I have a plateu 
   And the plateu is 5 units long by 5 units wide
   And a I have a rover at position 0,0 facing "North"
   When I give the rover the instructions "MMMRMMM0MMR"
   Then the rover should move until it reaches the position 2,2 
   And report to the screen "Warning: System has received an invalid instruction '#{instruction}', exiting system. No further move instructions will be processed."
   
   
