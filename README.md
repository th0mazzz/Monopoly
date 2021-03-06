# Monopoly
This is the board game Monopoly in Processing!. We implemented a lot of Monopoly's features, but ultimately, time ran out. Therefore, some features that are present in the game of Monopoly are not present here (like trading) and some features are not quite exactly the same as in the real board game.

# List of features
- Clicking in the middle of the board will roll the die and click again to end your turn
- Clicking on a property tile will bring up a pop-up menu asking you what to do
  -For the purposes of demonstration, you do NOT need a monopoly to build a house, you just need to own the property
  -Therefore, you can build a house!
  -You can also mortgage the house for half the purchase price
  -You can also unmortgage the house for the mortgage price.
- There is a scrolling history log in the bottom right hand corner of the window
- Landing on a Chance or Community Chest tile would result in pop-ups and the action would be automatically performed
- Landing on an unowned property gives you the option to buy or auction
  - Auctioning works like an actual auction: highest bidder wins
  - There are many rules to bidding that would lead to disqualification
- Automatic rent collection and performance of actions
- The window should be dynamic if you change size and keep ratio the same
- If you roll a double, you can roll again. If you roll three doubles in one turn you will be sent to jail automatically.
- When in jail you will start the turn with a prompt with multiple options :
  - Pay a fine of $50 : let's you get out of jail and have a normal turn.
  - Try to roll a double : if you roll a double you get to leave jail and advanced. Rolling a double in this case does not give you 
  another roll
  - Use a get out of jail card: Same as paying a fine with the exception that it is free.
# New Features since Demo
N/A

# Features that we wanted
- Trading among players
- Tokens for players

# Instructions
Open in Processing!
1. Enter the number of players. The minimum players is 2 and the maximum is 12. 
2. Enter the names of all the players. 
3. Choose whether to have the default game version. If you choose no, then select the amount of money each players starts with. 
4. Play the game.

# Controls
- Clicking on the blue portion of the board will either roll the dice or end your turn, depending on whether the dice had been rolled yet. You will automatically advance to the tile you rolled onto.
- Click on a property to view possible actions (you can only affect properties you own on your turn).
- Build a house by clicking on a property you wish to build on and the corresponding button. You can build a maximum of 4 houses. (Note: In actual Monopoly, you may only build if you have a monopoly. However, we disabled that restriction because the chances of obtaining a full Monopoly without trade is pretty slim.)
- Sell the house by clicking a property whose house you wish to sell and click the corresonding button.
- Build a hotel by clicking a property and the corresponding button. You can only build a hotel if you have 4 houses on a property. Doing so will remove the houses.
- Sell the hotel by clicking on a property and the corresponding button. When you sell a hotel, the 4 houses come back.
- Mortgage a property by clicking on a property and the corresponding button.
- Unmortgage a property by clicking on a property and the corresponding button.
- Landing on an unowned property will prompt you to either purchase it or auction it.
- Purchasing it will... purchase it.
- Auctioning it will continue until all but the highest bidder resigned.

# Cheats On
- The cheatsOn branch will allow you to control what the dice roll. You input the value of the left die and the value of the right die. The sum of the two dice is how many spaces you move.
- To get to cheatsOn, you merely do:

git checkout cheatsOn