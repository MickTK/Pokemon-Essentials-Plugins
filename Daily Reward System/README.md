![Essentials](https://badgen.net/badge/Essentials/20.1/orange)
![Version](https://badgen.net/badge/Version/1.1.0/cyan)

<p align="center">
<img width="200px" src="https://user-images.githubusercontent.com/63038410/223847714-1e08b0df-4f95-493d-bfeb-8b31ba950c8f.png">
</p>

<h1 align="center">Daily Reward System</h1>

<p align="center">
Rewards obtainable through daily logins.
</p>

## Overview
- Give rewards to the player based on: login number, consecutive logins and date
- Fully customizable

## Instructions
### Define rewards
Rewards can be defined in `rewards.rb`.

You can find useful instructions here: [Essentials Docs Wiki](https://essentialsdocs.fandom.com/wiki/Essentials_Docs_Wiki).

## Informations
| Information               | Description                                                                                                                     |
| :------------------------ | :------------------------------------------------------------------------------------------------------------------------------ |
| `pbDailyReward`           | Give rewards to the player. Returns `true` if the player was enabled to reedem the reward, `false` if they already redeemed it. |
| `DailyReward.reset`       | Reset the login counter.                                                                                                        |
| `DailyReward.last_login`  | Return the date of the last login.                                                                                              |
| `DailyReward.logins`      | Return the number of logins.                                                                                                    |
| `DailyReward.consecutive` | Return the number of consecutive logins.                                                                                        |

## Download
| Essentials | Version |                                                                                                                                                             |
| :--------: | :-----: | :---------------------------------------------------------------------------------------------------------------------------------------------------------: |
|    20.1    |  1.1.0  | [Download](https://github.com/MickTK/Pokemon-Essentials-Plugins/raw/main/Daily%20Reward%20System/releases/v21.1/%5Bv1.1.0%5D%20Daily%20Reward%20System.zip) |

<details>
<summary>Changelog</summary>

- 1.1.0
  - Added getters
  - Added the update checker

</details>

<br>

Inspired by [Custom Daily Reward](https://www.curseforge.com/minecraft/mc-mods/custom-daily-reward?page=2) for Minecraft.
