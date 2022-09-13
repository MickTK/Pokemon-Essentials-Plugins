#-------------------------------------------------------------------------------
# Settings
#-------------------------------------------------------------------------------
class PokemonColorVariants

  #-----------------------------------------------------------------------------
  # General
  #-----------------------------------------------------------------------------
  # The odds of a newly generated Pokémon being colored (out of 65536).
  HUE_POKEMON_CHANCE = 256 # default: 256 (256/65536 = 1/256)
  
  # Use only specific hues 
  SPECIFIC_HUE_ONLY = false

  # Hue map (works only if SPECIFIC_HUE_ONLY is true)
  POKEMON_HUE = {
    :PIKACHU => [120, 200, 280]
  }

  #-----------------------------------------------------------------------------
  # Breeding
  #-----------------------------------------------------------------------------
  # Change baby pokémon color based on the parents color.
  HEREDITY_TYPE = "average"

  # Change the egg color.
  APPLY_TO_EGG = true

end
