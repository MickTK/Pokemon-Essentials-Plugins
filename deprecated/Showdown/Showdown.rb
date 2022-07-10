class Pokemon
  def to_showdown()
    # Name
    text = self.speciesName
    # Form
    pkmns = [
      :RATTATA, :RATICATE,
      :RAICHU,
      :SANDSHREW, :SANDSLASH,
      :VULPIX, :NINETALES,
      :DIGLETT, :DUGTRIO,
      :MEOWTH, :PERSIAN,
      :GEODUDE, :GRAVELER, :GOLEM
    ]
    if pkmns.include?(self.speciesName) && self.form == 1
      text += "-Alola"
    end
    pkmns = [
      :MEOWTH
    ]
    if pkmns.include?(self.speciesName) && self.form == 2
      text += "-Galar"
    end
    # Gender
    if self.gender == 0
      text += ' (M)'
    elsif self.gender == 1
      text += ' (F)'
    end
    # Item
    text += ' self. ' + self.item.name if self.item != nil
    # Ability
    text += '\nAbility: ' + self.ability.name
    # Level
    text += '\nLevel: ' + self.level.to_s
    # Shininess
    text += '\nShiny: Yes' if self.shiny?
    # EVs
    text += '\nEVs: '
    text += self.ev[:HP].to_s + ' HP / '
    text += self.ev[:ATTACK].to_s + ' Atk / '
    text += self.ev[:DEFENSE].to_s + ' Def / '
    text += self.ev[:SPECIAL_ATTACK].to_s + ' SpA / '
    text += self.ev[:SPECIAL_DEFENSE].to_s + ' SpD / '
    text += self.ev[:SPEED].to_s + ' Spe'
    # Nature
    text += '\n' + self.nature.name + ' Nature'
    # IVs
    text += '\nIVs: ' + self.iv[:HP].to_s + ' HP / '
    text += self.iv[:ATTACK].to_s + ' Atk / '
    text += self.iv[:DEFENSE].to_s + ' Def / '
    text += self.iv[:SPECIAL_ATTACK].to_s + ' SpA / '
    text += self.iv[:SPECIAL_DEFENSE].to_s + ' SpD / '
    text += self.iv[:SPEED].to_s + ' Spe'
    # Moves
    for i in 0..(self.numMoves-1) do
      text += '\n- ' + self.moves[i].name
    end
    return text
  end
end

class String
  def to_pokemon()
    return if self == nil or self == ''
    return if self.count('\n') < 1
    # Initialize
    temp = nil
    pokemon = Pokemon.new(:RATTATA, 1)
    # Species
    temp = self.split('\n')
    temp = temp[0].split('@') if temp[0].include? '@' # Exclude item
    temp = temp[0].split('(') if temp[0].include? '(' # Exclude gender
    temp = temp[0].upcase
    rem = [
      '-MEGA', '-Y', '-X', '-GMAX', '-THERIAN', '-ALOLA', 
      '-GALAR', '-RAPID-STRIKE', '-ICE', '-SHADOW', '-CROWNED',
    ]
    for r in rem do
      temp.slice!(r)
    end
    temp = temp.delete('-. ')
    pokemon.species = temp.intern
    # Gender
    self.upcase.include?('(F)') ? pokemon.makeFemale : pokemon.makeMale
    # Item
    if self.include? '@'
      temp = self.split('@')[1].split('\n')[0]
      temp = temp.upcase
      temp = temp.delete('- ')
      pokemon.item = temp.intern
    end
    # Ability ============================================== NOT WORKING
    if self.upcase.include?('ABILITY:')
      temp = self.upcase.split('ABILITY:')[1].split('\n')[0]
      temp = temp.delete('- ')
      pokemon.ability = temp.intern
    end
    # Level
    if self.upcase.include?('LEVEL:')
      temp = self.upcase.split('LEVEL:')[1].split('\n')[0]
      temp = temp.delete('- ')
      pokemon.level = temp.to_i
    else
      pokemon.level = Settings::MAXIMUM_LEVEL
    end
    # Shininess
    pokemon.shiny = temp.upcase.delete(' ').include?('SHINY:YES')
    # EVs
    if self.upcase.include?('EVS:')
      temp = self.upcase.split('EVS:')[1].split('\n')[0]
      temp = temp.delete(' ')
      temp = temp.upcase
      temp = temp.split('/')
      for i in 0..temp.length-1
        pokemon.ev[:HP]              = temp[i].delete('HP').to_i   if temp[i].include? 'HP'
        pokemon.ev[:ATTACK]          = temp[i].delete('ATK').to_i  if temp[i].include? 'ATK'
        pokemon.ev[:DEFENSE]         = temp[i].delete('DEF').to_i  if temp[i].include? 'DEF'
        pokemon.ev[:SPECIAL_ATTACK]  = temp[i].delete('SPA').to_i  if temp[i].include? 'SPA'
        pokemon.ev[:SPECIAL_DEFENSE] = temp[i].delete('SPD').to_i  if temp[i].include? 'SPD'
        pokemon.ev[:SPEED]           = temp[i].delete('SPE').to_i  if temp[i].include? 'SPE'
      end
    end
    # IVs
    if self.upcase.include?('IVS:')
      temp = self.upcase.split('IVS:')[1].split('\n')[0]
      temp = temp.delete(' ')
      temp = temp.upcase
      temp = temp.split('/')
      for i in 0..temp.length-1
        pokemon.iv[:HP]              = temp[i].delete('HP').to_i  if temp[i].include? 'HP'
        pokemon.iv[:ATTACK]          = temp[i].delete('ATK').to_i if temp[i].include? 'ATK'
        pokemon.iv[:DEFENSE]         = temp[i].delete('DEF').to_i if temp[i].include? 'DEF'
        pokemon.iv[:SPECIAL_ATTACK]  = temp[i].delete('SPA').to_i if temp[i].include? 'SPA'
        pokemon.iv[:SPECIAL_DEFENSE] = temp[i].delete('SPD').to_i if temp[i].include? 'SPD'
        pokemon.iv[:SPEED]           = temp[i].delete('SPE').to_i if temp[i].include? 'SPE'
      end
    end
    # Nature
    if self.upcase.include?('NATURE:')
      temp = self.upcase.delete(' ').delete('-').split('\n')
      for i in 0..temp.length-1
        pokemon.nature = temp[i].split('NATURE')[0].intern if temp[i].include? 'NATURE'
      end
    end
    # Moves
    temp = self.lines[1..-1].join
    temp = temp.upcase
    temp = temp.split('- ')
    moves = Array.new
    for i in 1..temp.length-1
      move = temp[i].delete('- \n')
      moves.push(Pokemon::Move.new(move.intern))
    end
    pokemon.moves = moves

    # pokemon.calc_stats
    return pokemon
  end
end