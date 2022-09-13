class Pokemon
  attr_reader :hue

  def hue=(value)
    @hue = value.to_i.abs % 360
  end

  alias pokemon_color_variants_initialize initialize
  def initialize(species, level, owner = $player, withMoves = true, recheck_form = true)
    pokemon_color_variants_initialize(species,level,owner,withMoves,recheck_form)
    @hue = nil
  end
end
