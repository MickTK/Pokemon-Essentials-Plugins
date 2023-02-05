#==============================================================================
# PokemonColorVariants
#==============================================================================
module PokemonColorVariants
  def self.apply(*args)
    return if args.length <= 1
    for i in 1..(args.length-1) do 
      source = args[0]
      destination = args[i]

      case source
        when Pokemon
          source.hue? ? hue = source.hue % 360 : next
        when Integer
          hue = source % 360
        else
          next
      end
      
      case destination
        when Bitmap
          destination.hue_change(hue)
        when Pokemon || PictureEx
          destination.hue = hue
        when RPG::Event
          destination.pages[0].graphic.character_hue = hue
        when RPG::Event::Page
          destination.graphic.character_hue = hue
        when RPG::Event::Page::Graphic
          destination.character_hue = hue
        when Game_FollowingPkmn || FollowerData
          destination.character_hue = hue
      end
    end
  end
end

#==============================================================================
# Handlers
#==============================================================================
# Debug menu
MenuHandlers.add(:pokemon_debug_menu, :set_hue, {
  "name"   => _INTL("Set hue color"),
  "parent" => :cosmetic,
  "effect" => proc { |pkmn, pkmnid, heldpoke, settingUpBattle, screen|
    params = ChooseNumberParams.new
    params.setRange(0, 360)
    params.setDefaultValue(pkmn.hue ? pkmn.hue : 0)
    hue = pbMessageChooseNumber("\\ts[]" + _INTL("Set the Pokémon's hue color [0 - 360]"), params)
    hue = hue % 360
    if hue != pkmn.hue
      pkmn.hue = hue
      screen.pbRefreshSingle(pkmnid)
    end
    next false
  }
})
# Set hue value to wild pokemon
EventHandlers.add(:on_wild_pokemon_created,:pokemon_color_variants,
  proc { |pokemon|
    if PokemonColorVariants::HUE_POKEMON_CHANCE > rand(65536)
      if PokemonColorVariants::SPECIFIC_HUE_ONLY && PokemonColorVariants::POKEMON_HUE.include?(pokemon.species)
        hue = PokemonColorVariants::POKEMON_HUE[pokemon.species]
        pokemon.hue = hue[rand(hue.length)] % 360
      else
        pokemon.hue = rand(360)
      end
      pokemon.hue = 0 if PokemonColorVariants::SHINY_ONLY && !pokemon.shiny?
      pokemon.hue = 0 if PokemonColorVariants::SUPER_SHINY_ONLY && !pokemon.super_shiny?
    end
  }
)

#==============================================================================
# Pokemon
#==============================================================================
class Pokemon
  attr_reader :hue

  def hue=(value)
    @hue = value.to_i.abs % 360
  end
  def hue?
    return !(@hue == 0 || @hue == nil)
  end

  alias pokemon_color_variants_initialize initialize
  def initialize(species, level, owner = $player, withMoves = true, recheck_form = true)
    pokemon_color_variants_initialize(species,level,owner,withMoves,recheck_form)
    @hue = nil
  end
end

#==============================================================================
# Species
#==============================================================================
module GameData
  class Species
    Species.singleton_class.alias_method :pokemon_color_variants_sprite_bitmap_from_pokemon, :sprite_bitmap_from_pokemon
    def self.sprite_bitmap_from_pokemon(*params)
      ret = pokemon_color_variants_sprite_bitmap_from_pokemon(*params)
      pkmn = params[0]
      if pkmn.hue? && (!pkmn.egg? || (pkmn.egg? && PokemonColorVariants::APPLY_TO_EGG))
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

#==============================================================================
# PokemonIconSprite
#==============================================================================
class PokemonIconSprite < SpriteWrapper
  def pokemon=(value)
    @pokemon = value
    @animBitmap&.dispose
    @animBitmap = nil
    if !@pokemon
      self.bitmap = nil
      @currentFrame = 0
      @counter = 0
      return
    end
    hue = PokemonColorVariants::APPLY_TO_ICON && @pokemon.hue ? @pokemon.hue : 0
    hue = 0 if !PokemonColorVariants::APPLY_TO_EGG && @pokemon.egg?
    @animBitmap = AnimatedBitmap.new(GameData::Species.icon_filename_from_pokemon(value), hue)
    self.bitmap = @animBitmap.bitmap
    self.src_rect.width  = @animBitmap.height
    self.src_rect.height = @animBitmap.height
    @numFrames    = @animBitmap.width / @animBitmap.height
    @currentFrame = 0 if @currentFrame >= @numFrames
    changeOrigin
  end
end

#==============================================================================
# PokemonBoxIcon
#==============================================================================
class PokemonBoxIcon < IconSprite
  def refresh
    return if !@pokemon
    hue = PokemonColorVariants::APPLY_TO_ICON && @pokemon.hue ? @pokemon.hue : 0
    hue = 0 if !PokemonColorVariants::APPLY_TO_EGG && @pokemon.egg?
    self.setBitmap(GameData::Species.icon_filename_from_pokemon(@pokemon), hue)
    self.src_rect = Rect.new(0, 0, self.bitmap.height, self.bitmap.height)
  end
end

#==============================================================================
# EggGenerator
#==============================================================================
class DayCare
  module EggGenerator
    EggGenerator.singleton_class.alias_method :pokemon_color_variants_set_shininess, :set_shininess
    def self.set_shininess(egg, mother, father)
      pokemon_color_variants_set_shininess(egg,mother,father)
      if !PokemonColorVariants::SPECIFIC_HUE_ONLY
        if PokemonColorVariants::HEREDITY_TYPE.downcase == "single"
          egg.hue = rand(2) == 0 ? mother.hue : father.hue
        elsif PokemonColorVariants::HEREDITY_TYPE.downcase == "average"
          min, max = mother.hue, father.hue
          min, max = max, min if min > max
          egg.hue = (min + ((max - min) / 2)) % 360
        end
      end
    end
  end
end

#==============================================================================
# Trainer
#==============================================================================
module GameData
  class Trainer
    SCHEMA["Hue"] = [:hue, "u"] # PBS parameter
    alias :pokemon_color_variants_to_trainer :to_trainer
    def to_trainer
      trainer = pokemon_color_variants_to_trainer
      for i in 0..(trainer.party.length-1)
        PokemonColorVariants.apply(@pokemon[i][:hue],trainer.party[i])
      end
      return trainer
    end
  end
end
