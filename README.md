# Barista-Bonanza
A 2D cooking game made in the Godot game engine that is focused on being a barista at a coffee shop called Barista Bonanza.

## Jira
https://baristabonanza.atlassian.net/jira/software/projects/BAR/boards/1?atlOrigin=eyJpIjoiNjQxODIxZWMzYzEzNDZiOWFjNzFmMTZjMTkxN2U4ZDYiLCJwIjoiaiJ9

## Installation

- Install Godot (https://godotengine.org/) version 4.1 or later
- Once installed you will run it using the installed exe file. Open the project in godot.

## Branches

- Before merging your local branch with main please first merge it with dev_branch. From there we can merge dev_branch with main as larger project markers are hit.

## Code Layout

- Main scene is **start_menu.tscn**. Other scenes are in Levels.

## Tips
- In order to create a non-moving 2D image background add a parralax layer underneath the tilemap.
- If you want to have a button trigger some code, first select the button, then look at the inspector (on the right) and switch to the "Node" tab. This will list all of the signals that the button has. Double click on "on_pressed" (for example) and godot will insert a function that will serve as the callback for that signal. If you already wrote your code just move it into that function

## Game Design
- When espresso button is pressed you can either get frothed milk, milk, or espresso.
- The order requests will have different drinks like machiatto or a flat-white. These will require different ratios of the ingredients. 
- The point calculation of each drink will be hardcoded in and based on the complexity of the drink. Simpler drinks (like plain espresso with a point value of 1) will be worth less points. Points will be subtracted from the drink point total when the drink is made incorrectly. The final round score will be calculated as such:
	- Round Score = (Drink Point Total) + (Time Orders Completed In - Time Allotted for Round)
 	- *Time is in seconds.*
