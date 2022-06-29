# Day Care Overworld Pokémon
Show overworld day care pokémons.

## Instructions
1. Create two new events with the following settings:
```
Autonomous Movement:
  Type: Random
  Speed: 3: Slow
  Freq: 3: Low
Options Enabled:
  Move Animation
  Stop Animation
Trigger: Action Button
```
2. (Optional) Add for each one event the following code: `DayCare.overworld_interaction(day_care_id)`, where `day_care_id` specifies the pokémon to show and it should be `0` (for the first pokémon at the day care) or `1` (for the second pokémon at the day care).
3. Use `DayCare.set_overworld(event_id, day_care_id)` (for each pokémon) in a script to set the overworld sprites (you can eventually use a parallel process in the same map as the step 1 events). `event_id` is the id of the event where you want to set the sprite

## Informations
| Information | Description |
|:----------|:-------------|
| `DayCare.overworld_interaction(day_care_id)` | Set the event to reproduce the pokémon cry and inform the player about breeding status |
| `DayCare.set_overworld(event_id, day_care_id)` | Set overworld sprite (should be triggered every time player enters the map) |
