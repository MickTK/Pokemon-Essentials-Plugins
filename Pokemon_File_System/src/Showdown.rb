#===============================================================================
# Showdown
#===============================================================================
class Showdown

  # Hash map of all forms
  SHOWDOWN_FORM_MAP = {
    "Alolan"              => "Alola",
    "Galarian"            => "Galar",
    "Spiky-Eared"         => "Spiky-eared",
    "B"                   => "B",
    "C"                   => "C",
    "D"                   => "D",
    "E"                   => "E",
    "F"                   => "F",
    "G"                   => "G",
    "H"                   => "H",
    "I"                   => "I",
    "J"                   => "J",
    "K"                   => "K",
    "L"                   => "L",
    "M"                   => "M",
    "N"                   => "N",
    "O"                   => "O",
    "P"                   => "P",
    "Q"                   => "Q",
    "R"                   => "R",
    "S"                   => "S",
    "T"                   => "T",
    "U"                   => "U",
    "V"                   => "V",
    "W"                   => "W",
    "X"                   => "X",
    "Y"                   => "Y",
    "Z"                   => "Z",
    "!"                   => "Exclamation",
    "?"                   => "Question",
    "Sunny Form"          => "Sunny",
    "Rainy Form"          => "Rainy",
    "Snowy Form"          => "Snowy",
    "Attack Forme"        => "Attack",
    "Defense Forme"       => "Defense",
    "Speed Forme"         => "Speed",
    "Sandy Cloak"         => "Sandy",
    "Trash Cloak"         => "Trash",
    "Sunshine Form"       => "Sunshine",
    "East Sea"            => "East",
    "Heat Rotom"          => "Heat",
    "Wash Rotom"          => "Wash",
    "Frost Rotom"         => "Frost",
    "Fan Rotom"           => "Fan",
    "Mow Rotom"           => "Mow",
    "Sky Forme"           => "Sky",
    "Fighting Type"       => "Fighting",
    "Flying Type"         => "Flying",
    "Poison Type"         => "Poison",
    "Ground Type"         => "Ground",
    "Rock Type"           => "Rock",
    "Bug Type"            => "Bug",
    "Ghost Type"          => "Ghost",
    "Steel Type"          => "Steel",
    "Fire Type"           => "Fire",
    "Water Type"          => "Water",
    "Grass Type"          => "Grass",
    "Electric Type"       => "Electric",
    "Psychic Type"        => "Psychic",
    "Ice Type"            => "Ice",
    "Dragon Type"         => "Dragon",
    "Dark Type"           => "Dark",
    "Fairy Type"          => "Fairy",
    "Blue-Striped"        => "Blue-Striped",
    "Zen Mode"            => "Zen",
    "Galarian Zen Mode"   => "Galar-Zen",
    "Summer Form"         => "Summer",
    "Autumn Form"         => "Autumn",
    "Winter Form"         => "Winter",
    "Therian Forme"       => "Therian",
    "White Kyurem"        => "White",
    "Black Kyurem"        => "Black",
    "Resolute Form"       => "Resolute",
    "Pirouette Forme"     => "Pirouette",
    "Shock Drive"         => "Shock",
    "Burn Drive"          => "Burn",
    "Chill Drive"         => "Chill",
    "Douse Drive"         => "Douse",
    "Ash-Greninja"        => "Ash",
    "Continental Pattern" => "Continental",
    "Elegant Pattern"     => "Elegant",
    "Garden Pattern"      => "Garden",
    "High Plains Pattern" => "High Plains",
    "Icy Snow Pattern"    => "Ice Snow",
    "Jungle Pattern"      => "Jungle",
    "Marine Pattern"      => "Marine",
    "Meadow Pattern"      => "Meadow",
    "Modern Pattern"      => "Modern",
    "Monsoon Pattern"     => "Monsoon",
    "Ocean Pattern"       => "Ocean",
    "Polar Pattern"       => "Polar",
    "River Pattern"       => "River",
    "Sandstorm Pattern"   => "Sandstorm",
    "Savanna Pattern"     => "Savanna",
    "Sun Pattern"         => "Sun",
    "Tundra Pattern"      => "Tundra",
    "Fancy Pattern"       => "Fancy",
    "Poké Ball Pattern"   => "Pokeball",
    "Heart Trim"          => "Heart",
    "Star Trim"           => "Star",
    "Diamond Trim"        => "Diamond",
    "Debutante Trim"      => "Debutante",
    "Matron Trim"         => "Matron",
    "Dandy Trim"          => "Dandy",
    "Kabuki Trim"         => "Kabuki",
    "Pharaoh Trim"        => "Pharaoh",
    "Female"              => "F",
    "Blade Forme"         => "Blade",
    "Average Size"        => "Small",
    "Large Size"          => "Large",
    "Super Size"          => "Super",
    "Active Mode"         => "Neutral",
    "10% Forme"           => "10%",
    "Complete Forme"      => "Complete",
    "Hoopa Unbound"       => "Unbound",
    "Pom-Pom Style"       => "Pom-Pom",
    "Pa'u Style"          => "Pa'u",
    "Sensu Style"         => "Sensu",
    "Midnight Form"       => "Midnight",
    "Dusk Form"           => "Dusk",
    "School Form"         => "School",
    "Dusk Mane"           => "Dusk-Mane",
    "Dawn Wings"          => "Dawn-Wings",
    "Ultra Necrozma"      => "Ultra",
    "Original Color"      => "Original",
    "Gulping Form"        => "Gulping",
    "Gorging Form"        => "Gorging",
    "Low Key Form"        => "Low-Key",
    "Antique Form"        => "Antique",
    "Ruby Cream"          => "Ruby-Cream",
    "Matcha Cream"        => "Matcha-Cream",
    "Mint Cream"          => "Mint-Cream",
    "Lemon Cream"         => "Lemon-Cream",
    "Salted Cream"        => "Salted-Cream",
    "Ruby Swirl"          => "Ruby-Swirl",
    "Caramel Swirl"       => "Caramel-Swirl",
    "Rainbow Swirl"       => "Rainbow-Swirl",
    "Noice Face"          => "Noice",
    "Hangry Mode"         => "Hangry",
    "Rapid Strike Style"  => "Rapid-Strike",
    "Ice Rider"           => "Ice",
    "Shadow Rider"        => "Shadow",
    "Origin Forme"        => "Origin",
    "Type: Fighting"      => "Fighting",
    "Type: Flying"        => "Flying",
    "Type: Poison"        => "Poison",
    "Type: Ground"        => "Ground",
    "Type: Rock"          => "Rock",
    "Type: Bug"           => "Bug",
    "Type: Ghost"         => "Ghost",
    "Type: Steel"         => "Steel",
    "Type: Fire"          => "Fire",
    "Type: Water"         => "Water",
    "Type: Grass"         => "Grass",
    "Type: Electric"      => "Electric",
    "Type: Psychic"       => "Psychic",
    "Type: Ice"           => "Ice",
    "Type: Dragon"        => "Dragon",
    "Type: Dark"          => "Dark",
    "Type: Fairy"         => "Fairy",
    "Crowned Sword"       => "Crowned",
    "Crowned Shield"      => "Crowned",
    "Galarian Standard Mode" => "Galar",
    "Eternal Flower"      => "Eternal",
    "Yellow Flower"       => "Yellow",
    "Orange Flower"       => "Orange",
    "Blue Flower"         => "Blue ", 
    "White Flower"        => "White",
    "Red Core"            => "Red",
    "Orange Core"         => "Orange",
    "Yellow Core"         => "Yellow",
    "Green Core"          => "Green",
    "Blue Core"           => "Blue",
    "Indigo Core"         => "Indigo",
    "Violet Core"         => "Violet"
  }

  # Export pokémon as showdown formatted file
  def self.export(pkmn)
    return false if !pkmn.is_a?(Pokemon)

    # File name
    file_name = "/#{pkmn.name} - #{pkmn.personalID}.txt" # => "Pikachu - 98729.txt"
    file_path = PokemonFile::DIRECTORY + file_name

    # Create folder
    Dir.mkdir(PokemonFile::DIRECTORY) if !File.exists?(PokemonFile::DIRECTORY)

    # Write on file
    File.open(file_path, "w") { |file| 
      file.write(pkmn.to_showdown)
    }

    return true
  end
end

#===============================================================================
# Pokemon methods
#===============================================================================
class Pokemon

  # Return String in Showdown format
  def to_showdown()
    showdown = ""
  
    # Name - Species name - Form
		for sp in GameData::Species do
			if sp.species == @species && sp.form == @form
				form_name = sp.form_name
				break
			end
		end
    form_name = Showdown::SHOWDOWN_FORM_MAP.key?(form_name) ? Showdown::SHOWDOWN_FORM_MAP[form_name] : ""
  

		name = "#{GameData::Species.get(@species).name}"
    name = "#{name}-#{form_name}" if form_name != ""
    showdown += name
  
    # Gender
    gender = ""
    gender = "(M)" if @gender == 0
    gender = "(F)" if @gender == 1
    showdown += " #{gender}"
  
    # Item
    item = ""
    item = @item.name if @item != nil
    showdown += " @ #{item}" if item != ""
    showdown += "\n"
  
    # Ability
    showdown += "Ability: #{GameData::Ability.get(@ability).name}\n"
  
    # Level
    showdown += "Level: #{@level.to_s}\n" if @level < 100
  
    # Shininess
    showdown += "Shiny: Yes\n" if @shiny
  
    # Happiness
    showdown += "Happiness: #{@happiness}\n" if @happiness < 255
  
    # Nature
    showdown += "#{GameData::Nature.get(@nature).name} Nature\n"
  
    # Pokeball
    pokeball      = @poke_ball
    pokeball_name = GameData::Item.get(pokeball).name
    showdown += "Pokeball: #{pokeball_name}\n" if pokeball != :POKEBALL
  
    # EVs
    hp              = @ev[:HP].to_s
    attack          = @ev[:ATTACK].to_s
    defense         = @ev[:DEFENSE].to_s
    special_attack  = @ev[:SPECIAL_ATTACK].to_s
    special_defense = @ev[:SPECIAL_DEFENSE].to_s
    speed           = @ev[:SPEED].to_s
    showdown += "EVs: #{hp} HP / #{attack} Atk / #{defense} Def / "
    showdown += "#{special_attack} SpA / #{special_defense} SpD / #{speed} Spe\n"
  
    # IVs
    hp              = @iv[:HP].to_s
    attack          = @iv[:ATTACK].to_s
    defense         = @iv[:DEFENSE].to_s
    special_attack  = @iv[:SPECIAL_ATTACK].to_s
    special_defense = @iv[:SPECIAL_DEFENSE].to_s
    speed           = @iv[:SPEED].to_s
    showdown += "IVs: #{hp} HP / #{attack} Atk / #{defense} Def / "
    showdown += "#{special_attack} SpA / #{special_defense} SpD / #{speed} Spe\n"
  
    # Moves
    for i in 0..(@moves.length-1) do
      showdown += "- #{@moves[i].name}\n"
    end
  
    return showdown
  end
end
