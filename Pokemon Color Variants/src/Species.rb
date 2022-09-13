# Pokémon sprites (battle, summary, pc)
module GameData
  class Species
    Species.singleton_class.alias_method :essentials_sprite_bitmap_from_pokemon, :sprite_bitmap_from_pokemon
    def self.sprite_bitmap_from_pokemon(*params)
      ret = essentials_sprite_bitmap_from_pokemon(*params)
      pkmn = params[0]
      ret.hue_change(pkmn.hue) if pkmn.hue && (!pkmn.egg? || (pkmn.egg? && PokemonColorVariants::APPLY_TO_EGG))
      return ret
    end
  end
end
