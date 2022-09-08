#===============================================================================
# Wild Level Scaling
#===============================================================================
class WildLevelScaling
  # Private attributes
  @@status = nil
  @@min    = nil
  @@max    = nil
  
  # Getters
  def self.status; @@status; end
  def self.min; @@min; end
  def self.max; @@max; end
  
  # Disable scaling
  def self.disable
    @@status = nil
    @@min    = nil
    @@max    = nil
  end

  # Enable relative scaling
  def self.relative(min, max)
    @@status = "rel"
    @@min, @@max = level_check(min,max)
  end

  # Enable absolute scaling
  def self.absolute(min, max)
    @@status = "abs"
    @@min, @@max = level_check(min,max,"inc")
  end

  # Check the input
  private
  def self.level_check(min, max, type="")
    min = min.abs.clamp(1, Settings::MAXIMUM_LEVEL).to_i
    max = max.abs.clamp(1, Settings::MAXIMUM_LEVEL).to_i
    min, max = max, min if min > max && type == "inc"
    return min, max
  end

  # Event
  EventHandlers.add(:on_wild_pokemon_created,:wild_level_scaling,
    proc { |pokemon|
      # Check whitelist
      if WildLevelScaling::WHITELIST.include?($game_map.map_id)
        data = WildLevelScaling::WHITELIST[$game_map.map_id]
        if data[0].downcase == "relative"
          avg = pbBalancedLevel($player.party)
          min, max = level_check(avg-data[1],avg+data[2])
        elsif data[0].downcase == "absolute"
          min, max = level_check(data[1],data[2],"inc")
        else
          next
        end
      # Relative
      elsif WildLevelScaling.status == "rel" && !WildLevelScaling::BLACKLIST.include?($game_map.map_id)
        avg = pbBalancedLevel($player.party)
        min, max = level_check(avg-WildLevelScaling.min,avg+WildLevelScaling.max)
      # Absolute
      elsif WildLevelScaling.status == "abs" && !WildLevelScaling::BLACKLIST.include?($game_map.map_id)
        min, max = level_check(WildLevelScaling.min,WildLevelScaling.max,"inc")
      else
        next
      end
      # Stats
      level = (min + rand(max-min)).clamp(1, Settings::MAXIMUM_LEVEL)
      pokemon.level = level
      pokemon.calc_stats
      pokemon.reset_moves
    }
  )

  # Save/load data
  SaveData.register(:wild_level_scaling) do
    save_value { [@@status,@@min,@@max] }
    load_value do |data|
      @@status = data[0]
      @@min    = data[1]
      @@max    = data[2]
    end
  end
end
