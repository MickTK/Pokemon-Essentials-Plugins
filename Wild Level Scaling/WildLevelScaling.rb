class WildLevelScaling
  @@enabled       = true
  @@always_active = [81]
	@@never_active  = []
  @@min_level     = 5
  @@max_level     = 10

	def self.on()
		@@enabled = true
	end
	def self.off()
		@@enabled = false
  end
  
  def self.average_party_level
    pbBalancedLevel($player.party)
  end

  def self.min_level(x = nil)
    if x == nil
		  return @@min_level
    else
		  @@min_level = x.abs.clamp(1, Settings::MAXIMUM_LEVEL)
    end
	end

  def self.max_level(x = nil)
    if x == nil
		  return @@max_level
    else
		  @@max_level = x.abs.clamp(1, Settings::MAXIMUM_LEVEL)
    end
	end

  def self.range(min_level, max_level)
    min_level(min_level)
    max_level(max_level)
  end

	EventHandlers.add(:on_wild_pokemon_created,:wild_level_scaling,
		proc { |pokemon|
      if @@always_active.include?($game_map.map_id) || (@@enabled && !@@never_active.include?($game_map.map_id))
        if @@min_level <= @@max_level
          new_level = @@min_level + rand(@@max_level - @@min_level)
          new_level = new_level.clamp(1, Settings::MAXIMUM_LEVEL)
          pokemon.level = new_level
          pokemon.calc_stats
          pokemon.reset_moves
        end
      end
		}
	)
end
