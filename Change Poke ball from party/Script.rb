MenuHandlers.add(:party_menu, :pokeball, {
  "name"      => _INTL("Pokéball"),
  "order"     => 50,
  "condition" => proc { |screen, party, party_idx| next !party[party_idx].egg? },
  "effect"    => proc { |screen, party, party_idx|
		keep_old = false
    pkmn = party[party_idx]
		pbChooseItemFromList(_I("Choose a Poké ball"), 1, :MASTERBALL, :ULTRABALL, :GREATBALL, 
		:POKEBALL, :SAFARIBALL, :SPORTBALL, :NETBALL, :DIVEBALL, :NESTBALL, :REPEATBALL, 
		:TIMERBALL, :LUXURYBALL, :PREMIERBALL, :DUSKBALL, :HEALBALL, :QUICKBALL, 
		:CHERISHBALL, :FASTBALL, :LEVELBALL, :LUREBALL, :HEAVYBALL, :LOVEBALL, :FRIENDBALL, 
		:MOONBALL, :DREAMBALL, :BEASTBALL) { screen.pbUpdate }
		pokeball = $game_variables[1]
		if pokeball == nil || pokeball == :NONE
		elsif pokeball == pkmn.poke_ball
			screen.pbDisplay(_INTL(pkmn.name + " is already in a " + GameData::Item.get(pokeball).name + "!"))
		else
			$bag.remove(pokeball)
			$bag.add(pkmn.poke_ball) if keep_old
			pkmn.poke_ball = pokeball
			screen.pbDisplay(_INTL(pkmn.name + " is now in a " + GameData::Item.get(pokeball).name + "."))
		end
  }
})
