DailyReward::REWARDS = proc { |day, month, year, logins, consecutive|
  
  # Everyday
  $bag.add(:POKEBALL,5)

  # On Christmas day
  if day == 25 && month == 12
    pbAddPokemon(:DELIBIRD, 20)
  end

  # For 100 logins
  $bag.add(:MASTERBALL,1) if logins == 100

  # For 100 consecutive logins
  if consecutive == 100
    pkmn = Pokemon.new(:ARCEUS, 100)
    pkmn.makeShiny
    pbAddPokemon(pkmn)
  end
}