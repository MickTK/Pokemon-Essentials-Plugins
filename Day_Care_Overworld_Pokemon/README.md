# Day Care Overworld Pokémon
Show overworld day care pokémons.

<p align="center">
  <img src="https://user-images.githubusercontent.com/63038410/176746218-befaa891-62ba-4885-899a-982ef2a199e2.png" />
</p>

## Instructions
1. Create two new events and name them `poke1` and `poke2` (name conventions can be changed inside the script);
2. Make sure they have the following settings:
```
Autonomous Movement:
  Type: Random
Options Enabled:
  Move Animation
  Stop Animation
Trigger: Action Button
```
3. (Optional) Add for each event the following code: `DayCare.overworld_action(get_self)`.

## Informations
| Information | Description |
|:-|:-|
| `DayCare.overworld_update()` | Set the characters in the current map. Should be used if the pokémons are in the same map as the player when deposit/withdraw. |
| `DayCare.overworld_action(event)` | Used to play the cry and tell the player how much their pokémons are compatible. You can use `get_self` (like the instructions) as parameter to call the method from the event itself. |

## Updates
- 1.1.0
  - Added automatic spawn entering a map
  - Added ditto's transformation when there is another pokémon at the day care
  - Simplified event setup
