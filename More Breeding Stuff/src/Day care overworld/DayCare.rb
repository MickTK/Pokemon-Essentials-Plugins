class DayCare
  # Update overworld events
  def self.overworld_update()
    return if $game_map.events == nil
    for i in 0..$game_map.events.length do
      event = $game_map.events[i]
      if event == nil
        # Do nothing
      elsif [MoreBreedingStuff::DAY_CARE_OVERWORLD_1, MoreBreedingStuff::DAY_CARE_OVERWORLD_2].include?(event.name.downcase)
        day_care_id = event.name.downcase == MoreBreedingStuff::DAY_CARE_OVERWORLD_1 ? 0 : 1
        pkmn = $PokemonGlobal.day_care[day_care_id].pokemon
        if pkmn != nil

          # Ditto's transformation!
          if pkmn.species == :DITTO && DayCare.count == 2
            day_care_id = (day_care_id + 1) % 2
            pkmn = $PokemonGlobal.day_care[day_care_id].pokemon
          end

          # Set sprite
          event.character_name = "/Followers shiny/" + pkmn.name + ".png"	if  pkmn.shiny?
          event.character_name = "/Followers/"       + pkmn.name + ".png"	if !pkmn.shiny?
          event.move_speed     = 3
          event.move_frequency = 3
          event.turn_random

          #=====================================
          # Pokemon Color Variants compatibility
          #=====================================
          if PluginManager.installed?("Pokemon Color Variants")
            event.character_hue = pkmn.hue ? pkmn.hue : 0
          end
        else
          # Reset sprite
          event.character_name = ""
        end
      end
    end
  end
  # Update after deposit
  DayCare.singleton_class.alias_method :essentials_deposit, :deposit
  def self.deposit(party_index)
    essentials_deposit(party_index)
    overworld_update
  end
  # Update after withdraw
  DayCare.singleton_class.alias_method :essentials_withdraw, :withdraw
  def self.withdraw(index)
    essentials_withdraw(index)
    overworld_update
  end
  # Update overworld entering a map
  EventHandlers.add(:on_enter_map, :day_care_overworld_pokemon, 
    proc { |_old_map_id|
      overworld_update
    }
  )
  # Overworld pokemon action
  def self.overworld_action(event = nil)
    return if event == nil
    return if ![MoreBreedingStuff::DAY_CARE_OVERWORLD_1, MoreBreedingStuff::DAY_CARE_OVERWORLD_2].include?(event.name.downcase)
    day_care_id = event.name.downcase == MoreBreedingStuff::DAY_CARE_OVERWORLD_1 ? 0 : 1
    pkmn = $PokemonGlobal.day_care[day_care_id].pokemon
    pkmn.play_cry if pkmn != nil
    if DayCare.count == 1
      pbMessage(_INTL(pkmn.name + " is doing just fine."))
    elsif DayCare.count == 2
      DayCare.get_compatibility(1)
      case $game_variables[1]
      when 0
        pbMessage(_INTL("The two prefer to play with other Pokémon more than with each other."))
      when 1
        pbMessage(_INTL("The two don't seem to like each other much."))
      when 2
        pbMessage(_INTL("The two seem to get along."))
      when 3
        pbMessage(_INTL("The two seem to get along very well."))
      end
    end
  end
end
