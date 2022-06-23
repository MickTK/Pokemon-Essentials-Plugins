# Wild Level Scaling
Set wild pokemons level range dynamically.

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
| `WildLevelScaling.on` | Enable the event |
| `WildLevelScaling.off` | Disable the event |
| `WildLevelScaling.range(5, 10)` | Set minimum and maximum wild pokemon's level |
| `WildLevelScaling.min_level(20)` | Get/set minimum wild pokemon's level |
| `WildLevelScaling.max_level(50)` | Get/set maximum wild pokemon's level |
| `WildLevelScaling.average_party_level` | Average player's party level |

#### [[DOWNLOAD]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/MickTK/Essentials-Plugins/tree/main/Wild%20Level%20Scaling&fileName=WildLevelScaling&rootDirectory=true)
