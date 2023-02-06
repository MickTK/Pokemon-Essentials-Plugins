![Category](https://badgen.net/badge/Category/Utility/green)
![Essentials](https://badgen.net/badge/Essentials/20.1/orange)
![Version](https://badgen.net/badge/Version/2.0.0/cyan)

<p align="center">
<img width="200px" src="https://user-images.githubusercontent.com/63038410/189098583-95af91a4-6af2-46f7-b625-04567ac55a09.png">
</p>

<h1 align="center">Wild Level Scaling</h1>

<p align="center">
Set wild pokémon level dynamically.
</p>

<br>
<a href="https://micktk.github.io/Pokemon-Essentials-Plugins/index.html#/home?url=https://github.com/MickTK/Pokemon-Essentials-Plugins/tree/main/
Wild%20Level%20Scaling
&fileName=Wild%20Level%20Scaling
&rootDirectory=true"><p align="center">
<img src="https://custom-icon-badges.herokuapp.com/badge/-Download-red?style=for-the-badge&logo=download&logoColor=white">
</p></a>
<br>

## Instructions
Check `settings.rb` for configuration.

### Relative / absolute
`relative` means that the minimum level is the difference between the average player's party level and the minimum level the pokémon actually can have. The same thing happens for the maximum level.

`absolute` means that the minimum level is actually the minimum level the wild pokémon can have. Same for the maximum.

![reference](https://user-images.githubusercontent.com/63038410/188705146-012f1663-9bfd-45af-8ae6-93152d01a714.png)

### Whitelist and blacklist
The whitelist is used to set specific parameters for a single map. The scaling will be always on on these maps. The syntax is the following: `<map id> => [<type>, <minimum level>, <maximum level>]`.

`<type>` can be `"relative"` or `"absolute"`.

```
WHITELIST = {
  5  => ["relative", 3, 3],
  81 => ["absolute", 5, 10]
}
```

The blacklist contains the map ids where the level scaling is never applicable, even if the scaling is enable.

```
BLACKLIST = [26, 11]
```

## Informations
| Information | Description |
|:-|:-|
| `WildLevelScaling.relative(2,5)` | The wild pokémons will have a level between  [party average level - 2, party average level + 5]. |
| `WildLevelScaling.absolute(10,20)` | The wild pokémons will have a level between [10, 20]. |
| `WildLevelScaling.disable` | Turn off the scaling. The pokémons will have the level as defined in the PBS file. |
| `WildLevelScaling.min` | Return the current minimum level setted. `Nil` if disabled. |
| `WildLevelScaling.max` | Return the current maximum level setted. `Nil` if disabled. |
| `WildLevelScaling.status` | Return: `"rel"` / `"abs"` or `Nil` if disabled. |

<details>
<summary>Updates</summary>

#### 2.0.0
- Added the wild scaling level relative to the average player's party level
- Added the save state
- Added the updater
- Refactored the code

</details>
