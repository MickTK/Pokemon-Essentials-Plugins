class DayCare
	def self.set_overworld(event_id, day_care_id)
		return if day_care_id > 1 || day_care_id < 0
		pkmn = $PokemonGlobal.day_care[day_care_id].pokemon
		return if pkmn == nil || $game_map.events[event_id] == nil
		file_name = "/Followers shiny/" + pkmn.name + ".png"	if pkmn.shiny?
		file_name = "/Followers/" + pkmn.name + ".png"	if !pkmn.shiny?
		$game_map.events[event_id].character_name = file_name;
	end
	def self.overworld_interaction(day_care_id)
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
