# Pokémon sprites (battle, summary, pc)
module GameData
  class Species
    Species.singleton_class.alias_method :pokemon_color_variants_sprite_bitmap_from_pokemon, :sprite_bitmap_from_pokemon
    def self.sprite_bitmap_from_pokemon(*params)
      ret = pokemon_color_variants_sprite_bitmap_from_pokemon(*params)
      pkmn = params[0]
      if pkmn.hue && (!pkmn.egg? || (pkmn.egg? && PokemonColorVariants::APPLY_TO_EGG))
        begin
          ret.hue_change(pkmn.hue)
        rescue => exception
          ret.bitmap.hue_change(pkmn.hue)
        end
      end
      return ret
    end
  end
end
