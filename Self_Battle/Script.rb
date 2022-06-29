def pbSelfBattle()
	if $player.party.length < 2 || $player.able_party.length < 2
		pbMessage(_INTL("You don't have enough pokémons."))
		return
	end
	pbChoosePokemon(1,3)
	return if $game_variables[1] < 0
	pkmn = $player.party[$game_variables[1]]
	if pkmn.egg?
		pbMessage(_INTL("You cannot battle an egg."))
		return
	elsif pkmn.hp == 0
		pbMessage(_INTL("Cannot battle a fainted pokémon."))
		return
	end
	# Start battle
	$player.remove_pokemon_at_index($game_variables[1])
	setBattleRule("disablePokeBalls")
	setBattleRule("canLose")
	WildBattle.start(pkmn)
	pkmn.hp = 0
	pbAddPokemonSilent(pkmn)
end
