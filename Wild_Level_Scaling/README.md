![Category](https://badgen.net/badge/Category/Utility/green)
![Essentials](https://badgen.net/badge/Essentials/20.1/orange)
![Version](https://badgen.net/badge/Version/1.0.0/cyan)

<h1 align="center">Wild Level Scaling</h1>

<p align="center">
Set wild pokemons level range dynamically.
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/63038410/178109115-cc34535d-80cd-40dc-8055-314e56ea86d8.png" />
</p>

<br>
<a href="https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/MickTK/Pokemon-Essentials-Plugins/tree/main/Wild_Level_Scaling&fileName=Wild_Level_Scaling&rootDirectory=true"><p align="center">
<img src="https://custom-icon-badges.herokuapp.com/badge/-Download-red?style=for-the-badge&logo=download&logoColor=white">
</p></a>
<br>

### Always enable level scaling on a map
The following array contains al the maps ids where the event is always active (even if the event is disabled).
```
@@always_active = [23, 56, 48]
```

### Never enable level scaling on a map
The following array contains al the maps ids where the event is never active (even if the event is enabled).
```
@@never_active = [5, 17]
```

## Informations
| Information | Description |
|:----------|:-------------|
| `WildLevelScaling.on` | Enable the event. |
| `WildLevelScaling.off` | Disable the event. |
| `WildLevelScaling.range(5, 10)` | Set minimum and maximum wild pokemon's level. |
| `WildLevelScaling.min_level(20)` | Get/set minimum wild pokemon's level. |
| `WildLevelScaling.max_level(50)` | Get/set maximum wild pokemon's level. |
| `WildLevelScaling.average_party_level` | Average player's party level. |
