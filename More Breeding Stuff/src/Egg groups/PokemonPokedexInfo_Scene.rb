# Draw egg group(s) in the pokedex
if MoreBreedingStuff::SHOW_EGG_GROUPS_IN_POKEDEX
  class PokemonPokedexInfo_Scene
    alias essentials_drawPageInfo drawPageInfo
    def drawPageInfo
      essentials_drawPageInfo
      species_data = GameData::Species.get_species_form(@species, @form)
      overlay = @sprites["overlay"].bitmap
      if $player.owned?(@species)
        x = species_data.egg_groups.length > 1 ? 38 : 72
        y = 206
        space = 4
        species_data.egg_groups.each_with_index do |group, i|
          egg_rect = Rect.new(0, MoreBreedingStuff::ICON_LIST.index(group) * MoreBreedingStuff::ICON_HEIGHT, MoreBreedingStuff::ICON_WIDTH, MoreBreedingStuff::ICON_HEIGHT)
          overlay.blt(x + ((MoreBreedingStuff::ICON_WIDTH + space) * i), y, MoreBreedingStuff::EGG_GROUP_BITMAP.bitmap, egg_rect)
        end
      end
    end
  end
end
