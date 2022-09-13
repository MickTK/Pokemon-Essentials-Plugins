# Adds shiny odds from shiny parents
if MoreBreedingStuff::SHINY_ODDS_ENABLED
  class DayCare
    module EggGenerator
      EggGenerator.singleton_class.alias_method :more_breeding_stuff_set_shininess, :set_shininess
      def self.set_shininess(egg, mother, father)
        i = rand(65536)
        if father.shiny? && mother.shiny?
          egg.shiny = i < MoreBreedingStuff::SHINY_ODDS[1]
        elsif father.shiny? || mother.shiny?
          egg.shiny = i < MoreBreedingStuff::SHINY_ODDS[0]
        end
        more_breeding_stuff_set_shininess(egg, mother, father)
      end
    end
  end
end
