#===============================================================================
# Functions
#===============================================================================
def pbExportPokemonFile(pokemon = nil, animation = true)
  
  # If the Pokémon is chosen from the party or not
  from_party = !pokemon ? true : false

  # Choose Pokémon from party
  if !pokemon && $player.party.length > 1
    pbChoosePokemon(1,3)
    return false if pbGet(1) < 0
    pokemon = $player.party[pbGet(1)]
  end
  if pokemon.instance_of?(Pokemon)

    # Export Pokémon
    return false if !PokemonFile.export(pokemon)

    # Delete Pokémon from party
    if from_party && PokemonFile::DELETE_AFTER_EXPORT
      $player.remove_pokemon_at_index(pbGet(1))
    end

    # Scene animation
    PokemonFile_Scene.export_animation(pokemon) if animation

    return true
  end
  return false
end
def pbImportPokemonFile(animation = true, add_silent = true)
  
  # Import Pokémon
  pokemon = PokemonFile.import
  
  return false if !pokemon

  # Scene animation
  PokemonFile_Scene.import_animation(pokemon) if animation

  # Add Pokémon to party/pc
  add_silent ? pbAddPokemonSilent(pokemon) : pbAddPokemon(pokemon)
end

#===============================================================================
# PokemonFile
#===============================================================================
module PokemonFile
  
  # Export pokémon as file
  def self.export(pkmn)
    return false if !pkmn.is_a?(Pokemon)

    # File name
    star = pkmn.shiny? ? "★ " : ""
    file_name = "/#{star}#{pkmn.name} - #{pkmn.personalID}.pk" # => "Pikachu - 98729.pk"
    file_path = DIRECTORY + file_name

    # Create folder
    Dir.mkdir(DIRECTORY) if !File.exists?(DIRECTORY)

    # Write
    File.open(file_path, "wb") { |file| 
      Marshal.dump(pkmn.to_hash, file) 
    }

    return true
  end

  # Import pokémon from file
  def self.import()
    pkmn = nil

    # Retrieve all the files from the folder
    file_name = Dir.entries(DIRECTORY) #=> [".", "..", "config.h", "main.rb"]

    # Return false if the folder is empty
    return false if file_name.length < 3

    # Get the first file in the directory
    file_path = DIRECTORY + "/" + file_name[2]

    # Read from file
    File.open(file_path, "rb") { |file|
      data = Marshal.load(file)
      if data.is_a?(Hash)

        # Convert Hash to Pokemon
        pkmn = Pokemon.new(:RATTATA, 5)
        pkmn.from_hash(data)
        next
      end
      pkmn = [data]
      pkmn << Marshal.load(file) until file.eof?
    }

    return false if !pkmn.is_a?(Pokemon)

    # Delete the file
    File.delete(file_path) if DELETE_AFTER_IMPORT

    return pkmn
  end
end

#===============================================================================
# Pokemon methods
#===============================================================================
class Pokemon

  # Pokemon -> Hash
  def to_hash()
    map = {}
    map["species"] = species
    map["form"]    = form
    map["level"]   = level
    map["exp"]     = exp
    map["steps_to_hatch"] = steps_to_hatch
    map["gender"]  = gender
    map["shiny"]   = shiny?
    map["ability"] = ability.id
    map["nature"]  = nature.id
    map["item"]    = item ? item.id : nil
    map["mail"]    = mail ? {"item" => mail.item,"message" => mail.message,"sender" => mail.sender} : nil
    map["moves"]   = []
    for move in moves do
      map["moves"].append(move.id)
    end
    map["first_moves"] = first_moves
    map["ribbons"]     = ribbons
    map["cool"]        = cool
    map["beauty"]      = beauty
    map["cute"]        = cute
    map["smart"]       = smart
    map["tough"]       = tough
    map["sheen"]       = sheen
    map["pokerus"]     = pokerus
    map["name"]        = name
    map["happiness"]   = happiness
    map["poke_ball"]   = poke_ball
    map["markings"]    = markings
    map["iv"]          = iv
    map["ev"]          = ev
    map["owner"] = {
      "id" => owner.id,
      "name" => owner.name,
      "gender" => owner.gender,
      "language" => owner.language
    }
    map["obtain_method"]  = obtain_method
    map["obtain_map"]     = obtain_map
    map["obtain_text"]    = obtain_text
    map["obtain_level"]   = obtain_level
    map["hatched_map"]    = hatched_map
    map["timeReceived"]   = timeReceived
    map["timeEggHatched"] = timeEggHatched
    map["personalID"]     = personalID

    #=========================
    # ZUD Plugin compatibility
    #=========================
    if PluginManager.installed?("ZUD Mechanics") || 
       PluginManager.installed?("ZUD Plugin")
      
      # Version 20
      if Essentials::VERSION.include?("20")
        map["reverted"]    = @reverted
        map["dynamax_lvl"] = @dynamax_lvl
        map["gmax_factor"] = @gmax_factor

      # Version 19
      elsif Essentials::VERSION.include?("19")
        map["reverted"]    = @reverted
        map["dynamax_lvl"] = @dynamax_lvl
        map["gmax_factor"] = @gmaxfactor

      # Other versions
      else
        map["reverted"]    = false
        map["dynamax_lvl"] = 0
        map["gmax_factor"] = false
      end
    end

    #=====================================
    # Pokemon Color Variants compatibility
    #=====================================
    map["hue"] = @hue.is_a?(Integer) ? @hue : 0
    
    return map
  end

  # Hash map -> Pokemon
  def from_hash(map)
    begin
      @species        = GameData::Species.get(map["species"]).id
      @form           = map["form"]
      @level          = map["level"].clamp(1, Settings::MAXIMUM_LEVEL)
      @exp            = map["exp"] ? map["exp"] : 0
      @steps_to_hatch = map["steps_to_hatch"]
      @gender         = map["gender"]
      @shiny          = map["shiny"]
      @ability        = map["ability"]
      @nature         = map["nature"]
      @item           = map["item"] ? GameData::Item.get(map["item"]) : nil
      @mail           = map["mail"] ? Mail.new(map["mail"]["item"], map["mail"]["message"], map["mail"]["sender"]) : nil
      list = []
      for move in map["moves"] do
        list.append(Pokemon::Move.new(move))
      end
      @moves = list
      @first_moves = map["first_moves"]

      # Often ribbons freeze the game ¯\_(ツ)_/¯
      begin
        @ribbons = map["ribbons"]
      rescue Exception => e
        puts e.message
      end

      @cool        = map["cool"]
      @beauty      = map["beauty"]
      @cute        = map["cute"]
      @smart       = map["smart"]
      @tough       = map["tough"]
      @sheen       = map["sheen"]
      @pokerus     = map["pokerus"]
      @name        = map["name"]
      @happiness   = map["happiness"]
      @poke_ball   = map["poke_ball"]

      # Markings are treated in two different ways: 
      # - in v20 is an Array of Integers (only 0s and 1s)
      # - in v19 is an Integer used as a bitmap (0 -> no mark, 1 -> mark)
      # Values are read from right to left.
      if Essentials::VERSION.include?("20")
        if map["markings"].is_a?(Integer)
          bits = map["markings"].to_s(2).reverse.split(//)
          array = []
          for i in bits do
            array.append(i.to_i)
          end
          map["markings"] = array
        end
      elsif Essentials::VERSION.include?("19")
        if map["markings"].kind_of?(Array)
          bits = ""
          for i in map["markings"] do
            if !i
              bits = "0" + bits
            else
              bits = i.to_s + bits
            end
          end
          map["markings"] = bits.to_i(2)
        end
      end
      @markings    = map["markings"]

      @iv          = map["iv"]
      @ev          = map["ev"]
      @owner       = Pokemon::Owner.new(
        map["owner"]["id"],
        map["owner"]["name"],
        map["owner"]["gender"],
        map["owner"]["language"]
      )
      @obtain_method  = map["obtain_method"]
      @obtain_map     = map["obtain_map"]
      @obtain_text    = map["obtain_text"]
      @obtain_level   = map["obtain_level"]
      @hatched_map    = map["hatched_map"]
      @timeReceived   = map["timeReceived"]
      @timeEggHatched = map["timeEggHatched"]
      @personalID     = map["personalID"]

      #=========================
      # ZUD Plugin compatibility
      #=========================
      
      # Version 20
      if Essentials::VERSION.include?("20")
        @reverted    = map["reverted"]
        @dynamax_lvl = map["dynamax_lvl"]
        @gmax_factor = map["gmax_factor"] ? map["gmax_factor"] : map["gmaxfactor"]

      # Version 19
      elsif Essentials::VERSION.include?("19")
        @reverted    = map["reverted"]
        @dynamax_lvl = map["dynamax_lvl"]
        @gmaxfactor  = map["gmax_factor"] ? map["gmax_factor"] : map["gmaxfactor"]
      end

      #=====================================
      # Pokemon Color Variants compatibility
      #=====================================
      @hue = map["hue"].is_a?(Integer) ? map["hue"] : 0

      calc_stats
    rescue Exception => e
      puts e.message
    end
  end
end
