Settings::MOVE_RELEARNER_CAN_TEACH_MORE_MOVES = true
MenuHandlers.add(:party_menu, :relearn_move, {
  "name"      => _INTL("Relearn move"),
  "order"     => 50,
  "condition" => proc { |screen, party, party_idx| 
		next !party[party_idx].egg? && !party[party_idx].shadowPokemon? && party[party_idx].can_relearn_move? },
  "effect"    => proc { |screen, party, party_idx| pbRelearnMoveScreen(party[party_idx]) }
})
