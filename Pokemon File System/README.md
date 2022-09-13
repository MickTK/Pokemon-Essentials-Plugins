![Category](https://badgen.net/badge/Category/Utility/green)
![Essentials](https://badgen.net/badge/Essentials/20.1/orange)
![Version](https://badgen.net/badge/Version/1.1.1/cyan)

<p align="center">
<img width="200px" src="https://user-images.githubusercontent.com/63038410/178041105-855c7976-74ef-4400-8a16-a413cd65f489.png">
</p>

<h1 align="center">Pokémon File System</h1>

<p align="center">
Export/import Pokémons as files.
</p>
<p align="center">
Share them between different games (made with essentials) or trade them with your friends. 
<p>
<p align="center">
Works with Essentials v20.1 and v19.1 and is full compatible with the ZUD Plugin!
</p>

<br>
<a href="https://micktk.github.io/Pokemon-Essentials-Plugins/index.html#/home?url=https://github.com/MickTK/Pokemon-Essentials-Plugins/tree/main/
Pokemon%20File%20System
&fileName=Pokemon%20File%20System
&rootDirectory=true"><p align="center">
<img src="https://custom-icon-badges.herokuapp.com/badge/-Download-red?style=for-the-badge&logo=download&logoColor=white">
</p></a>
<br>

## Instructions

If you wanna transfer a pokémon from game A to game B you have to make sure that both games uses the same environment. For example if a pokémon is inside a "Cheese Ball" and it is trasfered to game B, game B should have the same ball, otherwise the game will crash. Same thing for pokémons, moves, ribbons and items in general.

For v19.1 usage: delete the "Essentials" line in the `meta.txt` file.

`PokemonFile_Scene` manages the animations for export and import (only for Essentials v20.1).

Check `settings.rb` for configuration.

## Informations
| Information | Description |
|:-|:-|
| `pbExportPokemonFile(nil, true)` | (v20.1 only) Export a Pokémon chosen from the party and show the animation. |
| `pbImportPokemonFile(true, true)` | (v20.1 only) Import a Pokémon, show the animation and add it silently. |
| `PokemonFile.export(pokemon)` | Export a Pokémon. |
| `PokemonFile.import` | Import a Pokémon. It will be the first file in the folder. |
| `Showdown.export(pokemon)` | Export a Pokémon in Showdown format. |

<details>
<summary>Updates</summary>

#### 1.1.1
- Added Pokemon Color Variants compatibility
- Added the updater

#### 1.1.0
- Added ZUD Plugin compatibility for Essentials v20.1
- Fixed some bugs for compatibility with Essentials v19.1

</details>
