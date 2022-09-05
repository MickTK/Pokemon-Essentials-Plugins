#===============================================================================
# PokemonFile_Scene
#===============================================================================
class PokemonFile_Scene
  
  #=============================================================================
  # Export animation
  #=============================================================================
  def self.export_animation(pokemon)
    pbFadeOutInWithMusic {
      evo = PokemonFile_Scene.new
      evo.start_export_screen(pokemon)
      evo.export_screen
      evo.end_export_screen
    }
  end
  def start_export_screen(pokemon)
    @sprites = {}
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
    @pokemon  = pokemon
    addBackgroundOrColoredPlane(@sprites, "background", "tradebg",
                                Color.new(248, 248, 248), @viewport)
    @sprites["rsprite1"] = PokemonSprite.new(@viewport)
    @sprites["rsprite1"].setPokemonBitmap(@pokemon, false)
    @sprites["rsprite1"].setOffset(PictureOrigin::BOTTOM)
    @sprites["rsprite1"].x = Graphics.width / 2
    @sprites["rsprite1"].y = 264
    @sprites["rsprite1"].z = 10
    @pokemon.species_data.apply_metrics_to_sprite(@sprites["rsprite1"], 1)
    @sprites["msgwindow"] = pbCreateMessageWindow(@viewport)
    pbFadeInAndShow(@sprites)
  end
  def export_screen
    @pokemon.play_cry
    pbMessageDisplay(@sprites["msgwindow"],
                     _ISPRINTF("{1:s}\r\nID: {2:05d}   OT: {3:s}\\wtnp[0]",
                               @pokemon.name, @pokemon.owner.public_id, @pokemon.owner.name)) { update_screen }
    pbMessageWaitForInput(@sprites["msgwindow"], 50, true) { update_screen }
    pbPlayDecisionSE
    export_scene
  end
  def export_scene
    spriteBall = IconSprite.new(0, 0, @viewport)
    pictureBall = PictureEx.new(0)
    picturePoke = PictureEx.new(0)
    ballimage = sprintf("Graphics/Battle animations/ball_%s", @pokemon.poke_ball)
    ballopenimage = sprintf("Graphics/Battle animations/ball_%s_open", @pokemon.poke_ball)
    # Starting position of ball
    pictureBall.setXY(0, Graphics.width / 2, 48)
    pictureBall.setName(0, ballimage)
    pictureBall.setSrcSize(0, 32, 64)
    pictureBall.setOrigin(0, PictureOrigin::CENTER)
    pictureBall.setVisible(0, true)
    # Starting position of sprite
    picturePoke.setXY(0, @sprites["rsprite1"].x, @sprites["rsprite1"].y)
    picturePoke.setOrigin(0, PictureOrigin::BOTTOM)
    picturePoke.setVisible(0, true)
    # Change Pokémon color
    picturePoke.moveColor(2, 5, Color.new(31 * 8, 22 * 8, 30 * 8, 255))
    # Recall
    delay = picturePoke.totalDuration
    picturePoke.setSE(delay, "Battle recall")
    pictureBall.setName(delay, ballopenimage)
    pictureBall.setSrcSize(delay, 32, 64)
    # Move sprite to ball
    picturePoke.moveZoom(delay, 8, 0)
    picturePoke.moveXY(delay, 8, Graphics.width / 2, 48)
    picturePoke.setSE(delay + 5, "Battle jump to ball")
    picturePoke.setVisible(delay + 8, false)
    delay = picturePoke.totalDuration + 1
    pictureBall.setName(delay, ballimage)
    pictureBall.setSrcSize(delay, 32, 64)
    # Make Poké Ball go off the top of the screen
    delay = picturePoke.totalDuration + 10
    pictureBall.moveXY(delay, 6, Graphics.width / 2, -32)
    # Play animation
    run_pictures(
      [picturePoke, pictureBall],
      [@sprites["rsprite1"], spriteBall]
    )
    spriteBall.dispose
  end
  def end_export_screen(need_fade_out = true)
    pbDisposeMessageWindow(@sprites["msgwindow"]) if @sprites["msgwindow"]
    pbFadeOutAndHide(@sprites) if need_fade_out
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
  
  #=============================================================================
  # Import animation
  #=============================================================================
  def self.import_animation(pokemon)
    pbFadeOutInWithMusic {
      evo = PokemonFile_Scene.new
      evo.start_import_screen(pokemon)
      evo.import_screen
      evo.end_import_screen
    }
  end
  def start_import_screen(pokemon)
    @sprites = {}
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
    @pokemon  = pokemon
    addBackgroundOrColoredPlane(@sprites, "background", "tradebg",
                                Color.new(248, 248, 248), @viewport)
    @sprites["rsprite2"] = PokemonSprite.new(@viewport)
    @sprites["rsprite2"].setPokemonBitmap(@pokemon, false)
    @sprites["rsprite2"].setOffset(PictureOrigin::BOTTOM)
    @sprites["rsprite2"].x = Graphics.width / 2
    @sprites["rsprite2"].y = 264
    @sprites["rsprite2"].z = 10
    @pokemon.species_data.apply_metrics_to_sprite(@sprites["rsprite2"], 1)
    @sprites["rsprite2"].visible = false
    @sprites["msgwindow"] = pbCreateMessageWindow(@viewport)
    pbFadeInAndShow(@sprites)
  end
  def import_screen
    was_owned = $player.owned?(@pokemon.species)
    $player.pokedex.register(@pokemon)
    $player.pokedex.set_owned(@pokemon.species)
    pbBGMStop
    @pokemon.play_cry
    speciesname = GameData::Species.get(@pokemon.species).name
    import_scene
    pbMessageDisplay(@sprites["msgwindow"],
                     _ISPRINTF("{1:s}\r\nID: {2:05d}   OT: {3:s}\1",
                               @pokemon.name, @pokemon.owner.public_id, @pokemon.owner.name)) { update_screen }
    pbMessageDisplay(@sprites["msgwindow"],
                     _INTL("Take good care of {1}.", speciesname)) { update_screen }
    # Show Pokédex entry for new species if it hasn't been owned before
    if Settings::SHOW_NEW_SPECIES_POKEDEX_ENTRY_MORE_OFTEN && !was_owned && $player.has_pokedex
      pbMessageDisplay(@sprites["msgwindow"],
                       _INTL("{1}'s data was added to the Pokédex.", speciesname)) { update_screen }
      $player.pokedex.register_last_seen(@pokemon)
      pbFadeOutIn {
        scene = PokemonPokedexInfo_Scene.new
        screen = PokemonPokedexInfoScreen.new(scene)
        screen.pbDexEntry(@pokemon.species)
        pbEndScreen(false)
      }
    end
  end
  def import_scene
    spriteBall = IconSprite.new(0, 0, @viewport)
    pictureBall = PictureEx.new(0)
    picturePoke = PictureEx.new(0)
    ballimage = sprintf("Graphics/Battle animations/ball_%s", @pokemon.poke_ball)
    ballopenimage = sprintf("Graphics/Battle animations/ball_%s_open", @pokemon.poke_ball)
    # Starting position of ball
    pictureBall.setXY(0, Graphics.width / 2, -32)
    pictureBall.setName(0, ballimage)
    pictureBall.setSrcSize(0, 32, 64)
    pictureBall.setOrigin(0, PictureOrigin::CENTER)
    pictureBall.setVisible(0, true)
    # Starting position of sprite
    picturePoke.setOrigin(0, PictureOrigin::BOTTOM)
    picturePoke.setZoom(0, 0)
    picturePoke.setColor(0, Color.new(31 * 8, 22 * 8, 30 * 8, 255))
    picturePoke.setVisible(0, false)
    # Dropping ball
    y = Graphics.height - 96 - 16 - 16   # end point of Poké Ball
    delay = picturePoke.totalDuration + 2
    4.times do |i|
      t = [4, 4, 3, 2][i]   # Time taken to rise or fall for each bounce
      d = [1, 2, 4, 8][i]   # Fraction of the starting height each bounce rises to
      delay -= t if i == 0
      if i > 0
        pictureBall.setZoomXY(delay, 100 + (5 * (5 - i)), 100 - (5 * (5 - i)))   # Squish
        pictureBall.moveZoom(delay, 2, 100)                      # Unsquish
        pictureBall.moveXY(delay, t, Graphics.width / 2, y - (100 / d))
      end
      pictureBall.moveXY(delay + t, t, Graphics.width / 2, y)
      pictureBall.setSE(delay + (2 * t), "Battle ball drop")
      delay = pictureBall.totalDuration
    end
    picturePoke.setXY(delay, Graphics.width / 2, y)
    # Open Poké Ball
    delay = pictureBall.totalDuration + 15
    pictureBall.setSE(delay, "Battle recall")
    pictureBall.setName(delay, ballopenimage)
    pictureBall.setSrcSize(delay, 32, 64)
    pictureBall.setVisible(delay + 5, false)
    # Pokémon appears and enlarges
    picturePoke.setVisible(delay, true)
    picturePoke.moveZoom(delay, 8, 100)
    picturePoke.moveXY(delay, 8, Graphics.width / 2, @sprites["rsprite2"].y)
    # Return Pokémon's color to normal and play cry
    delay = picturePoke.totalDuration
    picturePoke.moveColor(delay, 5, Color.new(31 * 8, 22 * 8, 30 * 8, 0))
    cry = GameData::Species.cry_filename_from_pokemon(@pokemon)
    picturePoke.setSE(delay, cry) if cry
    # Play animation
    run_pictures(
      [picturePoke, pictureBall],
      [@sprites["rsprite2"], spriteBall]
    )
    spriteBall.dispose
  end
  def end_import_screen(need_fade_out = true)
    pbDisposeMessageWindow(@sprites["msgwindow"]) if @sprites["msgwindow"]
    pbFadeOutAndHide(@sprites) if need_fade_out
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
    newspecies = @pokemon.check_evolution_on_trade(@pokemon)
    if newspecies && PokemonFile::EVOLVE_AFTER_IMPORT
      evo = PokemonEvolutionScene.new
      evo.pbStartScreen(@pokemon, newspecies)
      evo.pbEvolution(false)
      evo.pbEndScreen
    end
  end

  #=============================================================================
  # Shared
  #=============================================================================
  def update_screen
    pbUpdateSpriteHash(@sprites)
  end
  def run_pictures(pictures, sprites)
    loop do
      pictures.each { |pic| pic.update }
      sprites.each_with_index do |sprite, i|
        if sprite.is_a?(IconSprite)
          setPictureIconSprite(sprite, pictures[i])
        else
          setPictureSprite(sprite, pictures[i])
        end
      end
      Graphics.update
      Input.update
      running = false
      pictures.each { |pic| running = true if pic.running? }
      break if !running
    end
  end
end
