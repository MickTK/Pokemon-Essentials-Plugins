MenuHandlers.add(:party_menu, :pokeball, {
  "name"      => _INTL("Pokéball"),
  "order"     => 50,
  "condition" => proc { |screen, party, party_idx| 
		next TKPartyTweaks::CAN_CHANGE_POKEBALL && !party[party_idx].egg? 
	},
  "effect"    => proc { |screen, party, party_idx|
    pkmn = party[party_idx]
		pbChooseItem(1)
		pokeball_list = [
			:MASTERBALL, 
			:ULTRABALL, 
			:GREATBALL, 
			:POKEBALL, 
			:SAFARIBALL, 
			:SPORTBALL, 
			:NETBALL, 
			:DIVEBALL, 
			:NESTBALL, 
			:REPEATBALL, 
			:TIMERBALL, 
			:LUXURYBALL, 
			:PREMIERBALL, 
			:DUSKBALL, 
			:HEALBALL, 
			:QUICKBALL, 
			:CHERISHBALL, 
			:FASTBALL, 
			:LEVELBALL, 
			:LUREBALL, 
			:HEAVYBALL, 
			:LOVEBALL, 
			:FRIENDBALL, 
			:MOONBALL, 
			:DREAMBALL, 
			:BEASTBALL
		]
		pokeball = $game_variables[1]
		if !pokeball || pokeball == :NONE
		elsif !pokeball_list.include?(pokeball)
			screen.pbDisplay(_INTL("That's not a Poké ball!"))
		elsif pokeball == pkmn.poke_ball
			screen.pbDisplay(_INTL(pkmn.name + " is already in a " + GameData::Item.get(pokeball).name + "."))
		else
			$bag.remove(pokeball)
			$bag.add(pkmn.poke_ball) if TKPartyTweaks::KEEP_OLD_POKEBALL
			pkmn.poke_ball = pokeball
			screen.pbDisplay(_INTL(pkmn.name + " is now in a " + GameData::Item.get(pokeball).name + "."))
		end
  }
})
