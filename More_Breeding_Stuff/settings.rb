#===============================================================================
# Settings
#===============================================================================
module MoreBreedingStuff
  attr_reader

  #=============================================================================
  # Egg group(s)
  #=============================================================================
  SHOW_EGG_GROUPS_IN_SUMMARY = true
  SHOW_EGG_GROUPS_IN_POKEDEX = true
  
  #=============================================================================
  # Shiny odds
  #=============================================================================
  SHINY_ODDS_ENABLED = true # Set this to false if you want to use the default odds
  SHINY_ODDS = [
    16384, # If only one parent is shiny (out of 65536) (default: 16.384 | 25%)
    49152  # If both parents are shiny   (out of 65536) (default: 49.152 | 75%)
  ]

  #=============================================================================
  # Day-care overworld
  #=============================================================================
  DAY_CARE_OVERWORLD_1 = "poke1" # First pokémon overworld name event
	DAY_CARE_OVERWORLD_2 = "poke2" # Second pokémon overworld name event
  
end
