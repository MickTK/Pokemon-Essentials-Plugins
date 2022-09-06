def pbSelfTrade()
	pbChoosePokemon(1,3)
	return if $game_variables[1] < 0
	pkmn = $player.party[$game_variables[1]]
	pbStartTrade($game_variables[1], pkmn, pkmn.name, $player.name, $player.gender)
end
