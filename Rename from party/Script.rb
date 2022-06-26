MenuHandlers.add(:party_menu, :nickname, {
  "name"      => _INTL("Rename"),
  "order"     => 50,
  "condition" => proc { |screen, party, party_idx| next !party[party_idx].egg? },
  "effect"    => proc { |screen, party, party_idx|
    pkmn = party[party_idx]
		pkmn.name = pbEnterPokemonName(_INTL(pkmn.name + "'s nickname?"), 0, Pokemon::MAX_NAME_SIZE, pkmn.name, pkmn)
  }
})
