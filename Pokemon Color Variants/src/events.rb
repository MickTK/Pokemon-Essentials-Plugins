EventHandlers.add(:on_wild_pokemon_created,:pokemon_color_variants,
  proc { |pokemon|
    if PokemonColorVariants::HUE_POKEMON_CHANCE > rand(65536)
      if PokemonColorVariants::SPECIFIC_HUE_ONLY && PokemonColorVariants::POKEMON_HUE.include?(pokemon.species)
        hue = PokemonColorVariants::POKEMON_HUE[pokemon.species]
        pokemon.hue = hue[rand(hue.length)] % 360
      else
        pokemon.hue = rand(360)
      end
    end
  }
)
