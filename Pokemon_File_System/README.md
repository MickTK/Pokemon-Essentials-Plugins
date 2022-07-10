![Category](https://badgen.net/badge/Category/Utility/green)
![Essentials](https://badgen.net/badge/Essentials/20.1/orange)
![Version](https://badgen.net/badge/Version/1.0.0/cyan)

<p align="center">
<img width="200px" src="https://user-images.githubusercontent.com/63038410/178041105-855c7976-74ef-4400-8a16-a413cd65f489.png">
</p>

<h1 align="center">Pokémon File System</h1>

<p align="center">
Export/import Pokémons as files.
</p>
<p align="center">
Share them between different games (made with essentials) or trade them with your friends.
</p>

<br>
<a href="https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/MickTK/Essentials-Plugins/tree/main/Pokemon_File_System&fileName=Pokemon_File_System&rootDirectory=true"><p align="center">
<img src="https://custom-icon-badges.herokuapp.com/badge/-Download-red?style=for-the-badge&logo=download&logoColor=white">
</p></a>
<br>

## Instructions
`PokemonFile` is the core of the plugin. It contains the main methods for export and import a Pokémon as files. It works even for v19.1 and is compatible with ZUD Plugin.

`PokemonFile_Scene` manages the animations for the export and for the import.

`Showdown` converts and exports a Pokémon in Showdown format.

`pbExportPokemonFile` and `pbImportPokemonFile` work as wrappers.

Check `settings.rb` for configuration.

## Informations
| Information | Description |
|:-|:-|
| `pbExportPokemonFile(nil, true)` | Export a Pokémon chosen from the party and show the animation. |
| `pbImportPokemonFile(true, true)` | Import a Pokémon, show the animation and add it silently. |
| `PokemonFile.export(pokemon)` | Export a Pokémon. |
| `PokemonFile.import` | Import a Pokémon. It will be the first file in the folder. |
| `Showdown.export(pokemon)` | Export a Pokémon in Showdown format. |
