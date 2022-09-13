if PluginManager.installed?("Following Pokemon EX")
  module FollowingPkmn
    def self.pokemon_color_variants(pokemon)
      if pokemon.hue
        FollowingPkmn.get_event&.character_hue = pokemon.hue
        FollowingPkmn.get_data&.character_hue  = pokemon.hue
      end
    end
  end
end
