#===============================================================================
# Settings
#===============================================================================
module PokemonFile

	# Export settings
	DELETE_AFTER_EXPORT = true         # The Pokémon will be deleted from the party after export

	# Import settings
	DELETE_AFTER_IMPORT = true         # The file will be deleted after import
	EVOLVE_AFTER_IMPORT = false        # Evolve Pokémon if it can evolve from trade

	# Core settings
  DIRECTORY = Dir.pwd + "/Pokéfiles" # Folder that contains the files
end
