![Category](https://badgen.net/badge/Category/Gameplay/green)
![Essentials](https://badgen.net/badge/Essentials/20.1/orange)
![Version](https://badgen.net/badge/Version/1.1.0/cyan)

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

<div align="center">
  <details>
  <summary>Community picks ❤️</summary>
    <img width="450px" src="https://user-images.githubusercontent.com/63038410/216767202-dded7695-8f3b-4c67-a419-f87122cbe246.png">
    <p>LilyInTheWater's Pidgey</p><br>
    <img width="450px" src="https://user-images.githubusercontent.com/63038410/216767426-8a821395-efdb-4a84-922c-0aa356864f7f.png">
    <p>MaouAlter's Eelektross</p><br>
    <img width="450px" src="https://user-images.githubusercontent.com/63038410/220905142-de4e0835-9ce7-4a1e-95b4-e2785c531416.png">
    <p>Citycat17's Solgaleo</p>
  </details>
</div>

## Overview
- More than 700 color variants for each pokémon!
- Highly customizable
- Integrated breeding system
- Integrated wild encounter system

<br>
<a href="https://micktk.github.io/Pokemon-Essentials-Plugins/index.html#/home?url=https://github.com/MickTK/Pokemon-Essentials-Plugins/tree/main/
Pokemon%20Color%20Variants
&fileName=Pokemon%20Color%20Variants
&rootDirectory=true"><p align="center">
<img src="https://custom-icon-badges.herokuapp.com/badge/-Download-red?style=for-the-badge&logo=download&logoColor=white">
</p></a>
<br>

Pokemon Color Variants adds a function that can shift the hue color of a pokémon's sprite to make it looks more unique.
The plugin uses the hue attribute from RGSS3's Bitmap and Graphic classes to work.

A **debug menu** can be used from the party menu: `Debug > Cosmetic info... > Set hue color`.

Check `settings.rb` for the configurations.

### Random or specific hue(s)
Pokémons can have random or specific hues.
This can be defined in the setting `SPECIFIC_HUE_ONLY`.
If it is `true` you have to add the pokémon id and the hue(s) to `POKEMON_HUE` map as shown in the script (undefined pokémons will have only default color).

### Breeding
Pokémons can hereditate parents color from breeding.
It requires `SPECIFIC_HUE_ONLY` to be setted on `false`.

You can define the behaviour through `HEREDITY_TYPE`:
- `"single"`: hereditate the color of one parent.
- `"average"`: hereditate the average color of the parents (for instance, if its parents have 100 and 300 the newborn will have 200).

This mechanic can be disabled by setting `HEREDITY_TYPE` to `nil`.

### Trainer's pokemon
The hue of a trainer's pokemon can be specified in the PBS file `trainers.txt` by adding `Hue = <value>` at the end of the pokemon parameters as shown in the example.
```
Pokemon = ONIX,10
    Gender = male
    Moves = HEADSMASH,ROCKTHROW,RAGE,ROCKTOMB
    AbilityIndex = 0
    IV = 20,20,20,20,20,20
    Hue = 150
```

<br>

## Instructions
Some external plugins require some adds to work.

Check the `meta.txt` for the compatible plugins list.

Note: Deluxe animations (like mega evolution and dynamax) don't work with this plugin.

### Following Pokemon EX setup

<details>
<summary>Instructions</summary>

Setup Following Pokemon EX plugin:
1. Open the file `Following Pokemon EX > Main Module > Event_Sprite Commands.rb` from the plugin folder and go to the `change_sprite` method.
2. Copy and paste `PokemonColorVariants.apply(pkmn,FollowingPkmn.get_event,FollowingPkmn.get_data) if PluginManager.installed?("Pokemon Color Variants")` in the script as shown in the example below.
```ruby
  if FollowingPkmn.get_event&.move_route_forcing
    hue = pkmn.respond_to?(:superHue) && pkmn.superShiny? ? pkmn.superHue : 0
    FollowingPkmn.get_event&.character_hue  = hue
    FollowingPkmn.get_data&.character_hue   = hue
  end
  # Pokemon color variant
  PokemonColorVariants.apply(pkmn,FollowingPkmn.get_event,FollowingPkmn.get_data) if PluginManager.installed?("Pokemon Color Variants")
end
```

</details>

### Visible Overworld Wild Encounters setup

<details>
<summary>Instructions</summary>

Setup Visible Overworld Wild Encounters plugin:
1. Open the file `001_visible overworld wild encounters script.rb` from the plugin folder and go to the `Game_Map > spawnPokeEvent` method.
2. Copy and paste `PokemonColorVariants.apply(pokemon,event) if PluginManager.installed?("Pokemon Color Variants")` in the script as shown in the example below.
```ruby
#--- movement of the event --------------------------------
# Pokemon color variant
PokemonColorVariants.apply(pokemon,event) if PluginManager.installed?("Pokemon Color Variants")
event.pages[0].move_speed = VisibleEncounterSettings::DEFAULT_MOVEMENT[0]
event.pages[0].move_frequency = VisibleEncounterSettings::DEFAULT_MOVEMENT[1]
```

</details>

<br>

## Informations
| Information | Description |
|:-|:-|
| `(Pokemon) pokemon.hue = 180` | Get/set the pokémon hue. |
| `(Pokemon) pokemon.hue?` | Return `true` if the pokémon has an hue value, `false` otherwise. |

<br>

## Updates
<details>
<summary>Show</summary>

#### 1.1.0
  - Hue can now be applied to icons
  - Hue can now be applied to trainer's pokemons
  - Hue can now be applied to shiny and/or super shiny exclusively
  - Added a debug menu
  - Added compatibility with `Visible Overworld Wild Encounters` plugin

#### 1.0.1
  - Fixed compatibility bugs with third party plugins

</details>
