![Category](https://badgen.net/badge/Category/Utility/green)
![Essentials](https://badgen.net/badge/Essentials/20.1/orange)
![Version](https://badgen.net/badge/Version/1.0.2/cyan)

<h1 align="center">More Breeding Stuff</h1>

<p align="center">
Bundle of various scripts.
</p>

<div align="center">
  <details>
  <summary>Preview</summary>
    <img src="https://user-images.githubusercontent.com/63038410/188286454-5803e256-f1fc-4a1e-8512-94a99d288551.gif" />
    <p>Day-care overworld pokémons</p><br>
    <img src="https://user-images.githubusercontent.com/63038410/188286462-8c865156-8012-482a-af8a-254d6ac27878.png">
    <p>Egg group(s) in summary</p><br>
    <img src="https://user-images.githubusercontent.com/63038410/188286457-b7a88781-774c-422d-ba23-64b66420d32b.png">
    <p>Egg group(s) in pokedex</p>
  </details>
</div>

## Overview
- Day-care overworld pokémons
  - Show the pokémons at the day-care in the overworld as interactable events
- Egg groups
  - Show the egg groups in the summary screen and/or in the pokedex first page
- Breeding shiny odds
  - Adds customizable shiny odds from breeding based on the number of shiny parents 

<br>
<a href="https://micktk.github.io/Pokemon-Essentials-Plugins/index.html#/home?url=https://github.com/MickTK/Pokemon-Essentials-Plugins/tree/main/
More%20Breeding%20Stuff
&fileName=More%20Breeding%20Stuff
&rootDirectory=true"><p align="center">
<img src="https://custom-icon-badges.herokuapp.com/badge/-Download-red?style=for-the-badge&logo=download&logoColor=white">
</p></a>
<br>

## Instructions
Check `settings.rb` for configuration.

### Day-care overworld pokémons
1. Create two new events and name them `poke1` and `poke2` (name conventions can be changed inside from the settings);
2. Make sure they have `Move Animation` and `Stop Animation` checked;
3. (Optional) Add for each event the following code: `DayCare.overworld_action(get_self)`.

## Informations
| Information | Description |
|:-|:-|
| `DayCare.overworld_action(event)` | Used to play the cry and tell the player how much their pokémons are compatible. You can use `get_self` (like the instructions) as parameter to call the method from the event itself. |

<details>
<summary>Updates</summary>

#### 1.0.2
- Added Pokemon Color Variants compatibility

#### 1.0.1
- Corrected screen path
- Corrected directory url

</details>
<br>

## Credits
- [Lucidious89](https://reliccastle.com/members/7705/): egg group icons.
