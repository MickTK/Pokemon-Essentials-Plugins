class Pokemon
  def compatible_with_move?(move_id)
    move_data = GameData::Move.try_get(move_id)
    return move_data && species_data.tutor_moves.include?(move_data.id)
  end
end

# Party UI commands
class PokemonPartyScreen
	def pbPokemonScreen
		can_access_storage = false
		if ($player.has_box_link || $bag.has?(:POKEMONBOXLINK)) &&
			!$game_switches[Settings::DISABLE_BOX_LINK_SWITCH] &&
			!$game_map.metadata&.has_flag?("DisableBoxLink")
			can_access_storage = true
		end
		@scene.pbStartScene(@party,
												(@party.length > 1) ? _INTL("Choose a Pokémon.") : _INTL("Choose Pokémon or cancel."),
												nil, false, can_access_storage)
		# Main loop
		loop do
			# Choose a Pokémon or cancel or press Action to quick switch
			@scene.pbSetHelpText((@party.length > 1) ? _INTL("Choose a Pokémon.") : _INTL("Choose Pokémon or cancel."))
			party_idx = @scene.pbChoosePokemon(false, -1, 1)
			break if (party_idx.is_a?(Numeric) && party_idx < 0) || (party_idx.is_a?(Array) && party_idx[1] < 0)
			# Quick switch
			if party_idx.is_a?(Array) && party_idx[0] == 1   # Switch
				@scene.pbSetHelpText(_INTL("Move to where?"))
				old_party_idx = party_idx[1]
				party_idx = @scene.pbChoosePokemon(true, -1, 2)
				pbSwitch(old_party_idx, party_idx) if party_idx >= 0 && party_idx != old_party_idx
				next
			end
			# Chose a Pokémon
			pkmn = @party[party_idx]
			# Get all commands
			command_list = []
			commands = []
			MenuHandlers.each_available(:party_menu, self, @party, party_idx) do |option, hash, name|
				command_list.push(name)
				commands.push(hash)
			end
			command_list.push(_INTL("Cancel"))
			# Add field move commands
			if !pkmn.egg?
				insert_index = ($DEBUG) ? 2 : 1
				hms = [
					:CUT, :HEADBUTT, :ROCKSMASH, :STRENGTH, :SURF, :DIVE, 
					:WATERFALL, :CHATTER, :DIG, :TELEPORT, :FLASH, :MILKDRINK, 
					:SOFTBOILED, :SWEETSCENT, :FLY
				]
				map = {}
				i = 0
        # Add hm if can be used
				for hm in hms do 
          if (pkmn.hasMove?(hm) || pkmn.compatible_with_move?(hm)) && pbCanUseHiddenMove?(pkmn,hm,false)
            command_list.insert(insert_index, [GameData::Move.get(hm).name, 1])
            commands.insert(insert_index, i)
            map[i] = hm
            insert_index += 1
            i += 1
          end
				end
			end
			# Choose a menu option
			choice = @scene.pbShowCommands(_INTL("Do what with {1}?", pkmn.name), command_list)
			next if choice < 0 || choice >= commands.length
			# Effect of chosen menu option
			case commands[choice]
			when Hash   # Option defined via a MenuHandler below
				commands[choice]["effect"].call(self, @party, party_idx)
			when Integer   # Hidden move's index
				move_id = map[commands[choice]]
				if [:MILKDRINK, :SOFTBOILED].include?(move_id)
					amt = [(pkmn.totalhp / 5).floor, 1].max
					if pkmn.hp <= amt
						pbDisplay(_INTL("Not enough HP..."))
						next
					end
					@scene.pbSetHelpText(_INTL("Use on which Pokémon?"))
					old_party_idx = party_idx
					loop do
						@scene.pbPreSelect(old_party_idx)
						party_idx = @scene.pbChoosePokemon(true, party_idx)
						break if party_idx < 0
						newpkmn = @party[party_idx]
						movename = GameData::Move.get(move_id).name
						if party_idx == old_party_idx
							pbDisplay(_INTL("{1} can't use {2} on itself!", pkmn.name, movename))
						elsif newpkmn.egg?
							pbDisplay(_INTL("{1} can't be used on an Egg!", movename))
						elsif newpkmn.fainted? || newpkmn.hp == newpkmn.totalhp
							pbDisplay(_INTL("{1} can't be used on that Pokémon.", movename))
						else
							pkmn.hp -= amt
							hpgain = pbItemRestoreHP(newpkmn, amt)
							@scene.pbDisplay(_INTL("{1}'s HP was restored by {2} points.", newpkmn.name, hpgain))
							pbRefresh
						end
						break if pkmn.hp <= amt
					end
					@scene.pbSelect(old_party_idx)
					pbRefresh
				elsif pbCanUseHiddenMove?(pkmn, move_id)
					if pbConfirmUseHiddenMove(pkmn, move_id)
						@scene.pbEndScene
						if move_id == :FLY
							scene = PokemonRegionMap_Scene.new(-1, false)
							screen = PokemonRegionMapScreen.new(scene)
							ret = screen.pbStartFlyScreen
							if ret
								$game_temp.fly_destination = ret
								return [pkmn, move_id]
							end
							@scene.pbStartScene(
								@party, (@party.length > 1) ? _INTL("Choose a Pokémon.") : _INTL("Choose Pokémon or cancel.")
							)
							next
						end
						return [pkmn, move_id]
					end
				end
			end
		end
		@scene.pbEndScene
		return nil
	end
end
# Cut
def pbCut
  move = :CUT
  movefinder = nil
	for pkmn in $player.party do
		if pkmn.compatible_with_move?(move)
			movefinder = pkmn
			break
		end
	end
  if !$DEBUG && !movefinder
    pbMessage(_INTL("This tree looks like it can be cut down."))
    return false
  end
  if pbConfirmMessage(_INTL("This tree looks like it can be cut down!\nWould you like to cut it?"))
    $stats.cut_count += 1
    speciesname = (movefinder) ? movefinder.name : $player.name
    pbMessage(_INTL("{1} used {2}!", speciesname, GameData::Move.get(move).name))
    pbHiddenMoveAnimation(movefinder)
    return true
  end
  return false
end
HiddenMoveHandlers::CanUseMove.add(:CUT, proc { |move, pkmn, showmsg|
  facingEvent = $game_player.pbFacingEvent
  if !facingEvent || !facingEvent.name[/cuttree/i]
    pbMessage(_INTL("You can't use that here.")) if showmsg
    next false
  end
  next true
})
# Dive
def pbDive
  return false if $game_player.pbFacingEvent
  map_metadata = $game_map.metadata
  return false if !map_metadata || !map_metadata.dive_map_id
  move = :DIVE
  movefinder = nil
	for pkmn in $player.party do
		if pkmn.compatible_with_move?(move)
			movefinder = pkmn
			break
		end
	end
  if !$DEBUG && !movefinder
    pbMessage(_INTL("The sea is deep here. A Pokémon may be able to go underwater."))
    return false
  end
  if pbConfirmMessage(_INTL("The sea is deep here. Would you like to use Dive?"))
    speciesname = (movefinder) ? movefinder.name : $player.name
    pbMessage(_INTL("{1} used {2}!", speciesname, GameData::Move.get(move).name))
    pbHiddenMoveAnimation(movefinder)
    pbFadeOutIn {
      $game_temp.player_new_map_id    = map_metadata.dive_map_id
      $game_temp.player_new_x         = $game_player.x
      $game_temp.player_new_y         = $game_player.y
      $game_temp.player_new_direction = $game_player.direction
      $PokemonGlobal.surfing = false
      $PokemonGlobal.diving  = true
      $stats.dive_count += 1
      pbUpdateVehicle
      $scene.transfer_player(false)
      $game_map.autoplay
      $game_map.refresh
    }
    return true
  end
  return false
end
HiddenMoveHandlers::CanUseMove.add(:DIVE, proc { |move, pkmn, showmsg|
  if $PokemonGlobal.diving
    surface_map_id = nil
    GameData::MapMetadata.each do |map_data|
      next if !map_data.dive_map_id || map_data.dive_map_id != $game_map.map_id
      surface_map_id = map_data.id
      break
    end
    if !surface_map_id ||
       !$map_factory.getTerrainTag(surface_map_id, $game_player.x, $game_player.y).can_dive
      pbMessage(_INTL("You can't use that here.")) if showmsg
      next false
    end
  else
    if !$game_map.metadata&.dive_map_id
      pbMessage(_INTL("You can't use that here.")) if showmsg
      next false
    end
    if !$game_player.terrain_tag.can_dive
      pbMessage(_INTL("You can't use that here.")) if showmsg
      next false
    end
  end
  next true
})
# Flash
HiddenMoveHandlers::CanUseMove.add(:FLASH, proc { |move, pkmn, showmsg|
  if !$game_map.metadata&.dark_map
    pbMessage(_INTL("You can't use that here.")) if showmsg
    next false
  end
  if $PokemonGlobal.flashUsed
    pbMessage(_INTL("Flash is already being used.")) if showmsg
    next false
  end
  next true
})
# Fly
def pbCanFly?(pkmn = nil, show_messages = false)
  return false if !$DEBUG && !pkmn
  return false if pkmn == nil || !pkmn.compatible_with_move?(:FLY)
  if !$game_player.can_map_transfer_with_follower?
    pbMessage(_INTL("It can't be used when you have someone with you.")) if show_messages
    return false
  end
  if !$game_map.metadata&.outdoor_map
    pbMessage(_INTL("You can't use that here.")) if show_messages
    return false
  end
  return true
end
# Headbutt
def pbHeadbutt(event = nil)
  move = :HEADBUTT
  movefinder = nil
	for pkmn in $player.party do
		if pkmn.compatible_with_move?(move)
			movefinder = pkmn
			break
		end
	end
  if !$DEBUG && !movefinder
    pbMessage(_INTL("A Pokémon could be in this tree. Maybe a Pokémon could shake it."))
    return false
  end
  if pbConfirmMessage(_INTL("A Pokémon could be in this tree. Would you like to use Headbutt?"))
    $stats.headbutt_count += 1
    speciesname = (movefinder) ? movefinder.name : $player.name
    pbMessage(_INTL("{1} used {2}!", speciesname, GameData::Move.get(move).name))
    pbHiddenMoveAnimation(movefinder)
    pbHeadbuttEffect(event)
    return true
  end
  return false
end
# Rock Smash
def pbRockSmash
  move = :ROCKSMASH
  movefinder = nil
	for pkmn in $player.party do
		if pkmn.compatible_with_move?(move)
			movefinder = pkmn
			break
		end
	end
  if !$DEBUG && !movefinder
    pbMessage(_INTL("It's a rugged rock, but a Pokémon may be able to smash it."))
    return false
  end
  if pbConfirmMessage(_INTL("This rock seems breakable with a hidden move.\nWould you like to use Rock Smash?"))
    $stats.rock_smash_count += 1
    speciesname = (movefinder) ? movefinder.name : $player.name
    pbMessage(_INTL("{1} used {2}!", speciesname, GameData::Move.get(move).name))
    pbHiddenMoveAnimation(movefinder)
    return true
  end
  return false
end
HiddenMoveHandlers::CanUseMove.add(:ROCKSMASH, proc { |move, pkmn, showmsg|
  facingEvent = $game_player.pbFacingEvent
  if !facingEvent || !facingEvent.name[/smashrock/i]
    pbMessage(_INTL("You can't use that here.")) if showmsg
    next false
  end
  next true
})
# Strength
def pbStrength
  if $PokemonMap.strengthUsed
    pbMessage(_INTL("Strength made it possible to move boulders around."))
    return false
  end
  move = :STRENGTH
  movefinder = nil
	for pkmn in $player.party do
		if pkmn.compatible_with_move?(move)
			movefinder = pkmn
			break
		end
	end
  if !$DEBUG && !movefinder
    pbMessage(_INTL("It's a big boulder, but a Pokémon may be able to push it aside."))
    return false
  end
  pbMessage(_INTL("It's a big boulder, but you may be able to push it aside with a hidden move.\1"))
  if pbConfirmMessage(_INTL("Would you like to use Strength?"))
    speciesname = (movefinder) ? movefinder.name : $player.name
    pbMessage(_INTL("{1} used {2}!", speciesname, GameData::Move.get(move).name))
    pbHiddenMoveAnimation(movefinder)
    pbMessage(_INTL("Strength made it possible to move boulders around!"))
    $PokemonMap.strengthUsed = true
    return true
  end
  return false
end
HiddenMoveHandlers::CanUseMove.add(:STRENGTH, proc { |move, pkmn, showmsg|
  if $PokemonMap.strengthUsed
    pbMessage(_INTL("Strength is already being used.")) if showmsg
    next false
  end
  next true
})
# Surf
def pbSurf
  return false if $game_player.pbFacingEvent
  return false if !$game_player.can_ride_vehicle_with_follower?
  move = :SURF
  movefinder = nil
	for pkmn in $player.party do
		if pkmn.compatible_with_move?(move)
			movefinder = pkmn
			break
		end
	end
  if !$DEBUG && !movefinder
    return false
  end
  if pbConfirmMessage(_INTL("The water is a deep blue color... Would you like to use Surf on it?"))
    speciesname = (movefinder) ? movefinder.name : $player.name
    pbMessage(_INTL("{1} used {2}!", speciesname, GameData::Move.get(move).name))
    pbCancelVehicles
    pbHiddenMoveAnimation(movefinder)
    surfbgm = GameData::Metadata.get.surf_BGM
    pbCueBGM(surfbgm, 0.5) if surfbgm
    pbStartSurfing
    return true
  end
  return false
end
HiddenMoveHandlers::CanUseMove.add(:SURF, proc { |move, pkmn, showmsg|
  if $PokemonGlobal.surfing
    pbMessage(_INTL("You're already surfing.")) if showmsg
    next false
  end
  if !$game_player.can_ride_vehicle_with_follower?
    pbMessage(_INTL("It can't be used when you have someone with you.")) if showmsg
    next false
  end
  if $game_map.metadata&.always_bicycle
    pbMessage(_INTL("Let's enjoy cycling!")) if showmsg
    next false
  end
  if !$game_player.pbFacingTerrainTag.can_surf_freely ||
     !$game_map.passable?($game_player.x, $game_player.y, $game_player.direction, $game_player)
    pbMessage(_INTL("No surfing here!")) if showmsg
    next false
  end
  next true
})
# Waterfall
def pbWaterfall
  move = :WATERFALL
  movefinder = nil
	for pkmn in $player.party do
		if pkmn.compatible_with_move?(move)
			movefinder = pkmn
			break
		end
	end
  if !$DEBUG && !movefinder
    pbMessage(_INTL("A wall of water is crashing down with a mighty roar."))
    return false
  end
  if pbConfirmMessage(_INTL("It's a large waterfall. Would you like to use Waterfall?"))
    speciesname = (movefinder) ? movefinder.name : $player.name
    pbMessage(_INTL("{1} used {2}!", speciesname, GameData::Move.get(move).name))
    pbHiddenMoveAnimation(movefinder)
    pbAscendWaterfall
    return true
  end
  return false
end
HiddenMoveHandlers::CanUseMove.add(:WATERFALL, proc { |move, pkmn, showmsg|
  if !$game_player.pbFacingTerrainTag.waterfall
    pbMessage(_INTL("You can't use that here.")) if showmsg
    next false
  end
  next true
})
