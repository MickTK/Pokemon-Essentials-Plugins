class DailyReward; REWARDS = proc { |day, month, year, logins, consecutive|
    #================================================================
    # Begin
    #================================================================
    # Informations:
    # logins == n          : the nth login
    # consecutive == n     : the nth consecutive login
    # day==n or day(n)     : the nth day of every month and year
    # month==n or month(n) : every day of the nth month of every year
    # year==n or year(n)   : every day of the year n
    # date(dd,mm,yyyy)     : specific date
    #================================================================

    # Everyday
    $bag.add(:POKEBALL,5)

    # On Christmas day
    if day(25) and month(12)
      pbAddPokemon(:DELIBIRD,20)
    end

    # For 100 logins
    $bag.add(:MASTERBALL,1) if logins == 100

    # For 100 consecutive logins
    if consecutive == 100
      pkmn = Pokemon.new(:ARCEUS, 100)
      pkmn.makeShiny
      pbAddPokemon(pkmn)
    end

    #================================================================
    # End
    #================================================================
  }
end
