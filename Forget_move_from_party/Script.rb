MenuHandlers.add(:party_menu, :forget_move, {
  "name"      => _INTL("Forget move"),
  "order"     => 50,
  "condition" => proc { |screen, party, party_idx| 
		next !party[party_idx].egg? && !party[party_idx].shadowPokemon? && party[party_idx].numMoves > 1 &&
		($player.party[party_idx].hasMove?(:AMNESIA) || $player.get_pokemon_with_move(:HYPNOSIS))
	},
  "effect"    => proc { |screen, party, party_idx|
		pkmn = $player.party[party_idx]
		pbChooseMove(pkmn, 2, 4)
		if $game_variables[4] != :NONE && $game_variables[4] != nil && $game_variables[2] > -1
			screen.pbDisplay(_INTL(pkmn.name + " forgot " + $game_variables[4] + "."))
			pkmn.forget_move_at_index($game_variables[2])
		end
  }
})
