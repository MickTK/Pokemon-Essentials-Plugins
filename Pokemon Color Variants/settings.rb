#==============================================================================
# Settings
#==============================================================================
module PokemonColorVariants

  # The odds of a newly generated Pokémon having an hue color (out of 65536)
  HUE_POKEMON_CHANCE = 256   # default: 256 (256/65536 = 1/256)
  
  # Apply rules
  APPLY_TO_EGG     = false # Apply the hue shift to the eggs
  APPLY_TO_ICON    = true  # Apply the hue shift to the icons
  SHINY_ONLY       = false # Apply hue shift only on shiny pokemons
  SUPER_SHINY_ONLY = false # Apply hue shift only on super shiny pokemons
  
  # Specific hue(s)
  SPECIFIC_HUE_ONLY = false     # Use only specific hues
  POKEMON_HUE = {               # Hue map (works only if SPECIFIC_HUE_ONLY is true)
    :PIKACHU => [120, 200, 280] # Example: {:SPECIES => [value1, value2, ...]}
  }

  # Change newborn pokémon hue color based on the parents color
  # nil       -> disabled
  # "single"  -> hereditate the color of one parent
  # "average" -> hereditate the average color of the parents
  HEREDITY_TYPE = "average"

  CHECK_FOR_UPDATES = true  # Check if there is an updated version of the script
end
