class DayCare
	# Overworld events name
	@@overworld_name_1 = "poke1"
	@@overworld_name_2 = "poke2"

	# Update overworld events
	def self.overworld_update()
		return if $game_map.events == nil
		for i in 0..$game_map.events.length do
			event = $game_map.events[i]
			if event == nil
				# Do nothing
			elsif [@@overworld_name_1, @@overworld_name_2].include?(event.name.downcase)
				day_care_id = event.name.downcase == @@overworld_name_1 ? 0 : 1
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
				end
			end
		end
	end
	EventHandlers.add(:on_enter_map, :day_care_overworld_pokemon, 
		proc { |_old_map_id|
			overworld_update
		}
	)
	# Overworld pokemon action
	def self.overworld_action(event = nil)
		return if event == nil
		return if ![@@overworld_name_1, @@overworld_name_2].include?(event.name.downcase)
		day_care_id = event.name.downcase == @@overworld_name_1 ? 0 : 1
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
