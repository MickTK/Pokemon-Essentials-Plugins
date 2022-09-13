class DayCare
  module EggGenerator
    EggGenerator.singleton_class.alias_method :pokemon_color_variants_set_shininess, :set_shininess
    def self.set_shininess(egg, mother, father)
      if !PokemonColorVariants::SPECIFIC_HUE_ONLY
        if PokemonColorVariants::HEREDITY_TYPE.downcase == "single"
          if PokemonColorVariants::HUE_POKEMON_CHANCE > rand(65536)
            egg.hue = rand(2) == 0 ? mother.hue : father.hue
          end
        elsif PokemonColorVariants::HEREDITY_TYPE.downcase == "average"
          min, max = mother.hue, father.hue
          min, max = max, min if min > max
          egg.hue = (min + ((max - min) / 2)) % 360
        end
      end
      pokemon_color_variants_set_shininess(egg,mother,father)
    end
  end
end
