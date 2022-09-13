![Category](https://badgen.net/badge/Category/Gameplay/green)
![Essentials](https://badgen.net/badge/Essentials/20.1/orange)
![Version](https://badgen.net/badge/Version/1.0.0/cyan)

<p align="center">
<img width="200px" src="https://user-images.githubusercontent.com/63038410/189546697-067374fd-5a8d-43d5-941b-cb1f338c09a0.png">
</p>

<h1 align="center">Pokemon Color Variants</h1>

<p align="center">
Forge your rainbow team!
</p>

<div align="center">
  <details>
  <summary>Preview</summary>
    <img src="https://user-images.githubusercontent.com/63038410/189638185-6cb01896-b0bc-49dd-a800-5cd10fa734a2.gif">
    <p>Wild encounter</p><br>
    <img src="https://user-images.githubusercontent.com/63038410/189638258-8d08e41d-4ee8-496e-8ed2-9b45b9e6a1b1.gif">
    <p>A walk with Scyther</p><br>
    <img src="https://user-images.githubusercontent.com/63038410/189638289-beab8591-be64-4857-aa75-5bea1396aec7.gif">
    <p>Pc showcase</p>
  </details>
</div>

## Overview
- 700+ color variants for each pokémon (360 normal + 360 shiny)
- Set individually color variants that can be found in the wild
- Customizable encounter odds
- Pokémons can heredit its parent colors from breeding

<br>
<a href="https://micktk.github.io/Pokemon-Essentials-Plugins/index.html#/home?url=https://github.com/MickTK/Pokemon-Essentials-Plugins/tree/main/
Pokemon%20Color%20Variants
&fileName=Pokemon%20Color%20Variants
&rootDirectory=true"><p align="center">
<img src="https://custom-icon-badges.herokuapp.com/badge/-Download-red?style=for-the-badge&logo=download&logoColor=white">
</p></a>
<br>

## Instructions
Check `settings.rb` for configuration.

### Specific hue(s)
Pokémons can have random or specific hues. This can be defined setting `SPECIFIC_HUE_ONLY`. If it is `true` you have to add the pokémon id and the hues to `POKEMON_HUE` map as shown in the script (missing pokémons will have only default color). With this parameter setted to `true` you cannot use the breeding mechanics.

### Breeding
`HEREDITY_TYPE` defines the behavior for breeding.

There are 2 types of heredity:
- `"single"`: the pokémon will heredit the color from one parent. There are `HUE_POKEMON_CHANCE` chances that this happens;
- `"average"`: the pokémon will have the hue that stays between its parent hues. For example if its parents have 100 and 300 the baby will have 200.

You can disable this by setting it to `nil`.

### Following Pokemon EX
Setup Following Pokemon EX plugin:
1. Open the file `Following Pokemon EX > Main Module > Event_Sprite Commands.rb` from the plugin folder.
2. Copy and paste `FollowingPkmn.pokemon_color_variants(pkmn) if PluginManager.installed?("Pokemon Color Variants")` in the script as shown in the example below.
![image](https://user-images.githubusercontent.com/63038410/189639758-fb193f07-a6dc-4a3c-9454-f655c33ac489.png)

## Informations
| Information | Description |
|:-|:-|
| `pokemon.hue = 180` | Get/set the pokémon hue. |
