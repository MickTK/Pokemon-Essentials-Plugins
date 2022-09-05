#===============================================================================
# OverworldFlyAnimation
#===============================================================================
class OverworldFlyAnimation
  @@width  = Settings::SCREEN_WIDTH
  @@height = Settings::SCREEN_HEIGHT

  @@time_fly = 25
  @@zoom_increase_value = 0.08

  def self.departure()
    graphic = CHARACTER_PLAYER[$player.character_ID - 1]

    # Player showing the pokéball
    $game_player.turn_down
    $game_player.character_name = pbGetPlayerCharset(graphic[0])
		pbWait(6)
    $game_player.turn_down
    pbWait(4)
    $game_player.turn_left
    pbWait(4)
    $game_player.turn_right
    pbWait(4)
    $game_player.turn_up
    pbWait(6)
    $game_player.character_name = pbGetPlayerCharset(graphic[1])
    pbWait(8)

    # Bird flying from the pokéball
		viewport = Viewport.new(0, 0, @@width, @@height)
		viewport.z = 999999
		sprite = {}
		sprite[@@character_bird] = Sprite.new(viewport)
		sprite[@@character_bird].bitmap = RPG::Cache.picture(@@character_bird)
		sprite[@@character_bird].ox = sprite[@@character_bird].bitmap.width / 2
		sprite[@@character_bird].oy = sprite[@@character_bird].bitmap.height / 2
		sprite[@@character_bird].x  = @@width / 2 + 16
		sprite[@@character_bird].y  = @@height / 2
		sprite[@@character_bird].angle = 270
		sprite[@@character_bird].zoom_x = 0
    sprite[@@character_bird].zoom_y = 0
		time = 2
		value = 5.to_f
		distance = (@@height / 2 + sprite[@@character_bird].oy).to_f
		zoom = (value.to_f * time) / distance
		loop do
			Graphics.update
			pbUpdateSpriteHash(sprite)
			sprite[@@character_bird].y -= value * time
      sprite[@@character_bird].zoom_x += zoom
      sprite[@@character_bird].zoom_y += zoom
      break if sprite[@@character_bird].y <= -sprite[@@character_bird].oy
		end
		pbDisposeSpriteHash(sprite)
		viewport.dispose
    pbWait(4)

    # Player hiding the pokéball
		$game_player.character_name = pbGetPlayerCharset(graphic[0])
		pbWait(6)
    $game_player.turn_up
    pbWait(4)
    $game_player.turn_right
    pbWait(4)
    $game_player.turn_left
    pbWait(4)
    $game_player.turn_down
    pbWait(4)
    $game_player.refresh_charset
    pbWait(6)

    # Player riding the bird animation
    $game_player.turn_left
    pbSEPlay(@@se_bird)
    viewport = Viewport.new(0, 0, @@width, @@height)
    viewport.z = 999999
    pictureBird = Sprite.new(viewport)
    pictureBird.bitmap = RPG::Cache.picture(@@character_bird)
    pictureBird.ox = pictureBird.bitmap.width / 2
    pictureBird.oy = pictureBird.bitmap.height / 2
    pictureBird.x  = @@width + pictureBird.bitmap.width
    pictureBird.y  = @@height / 4
    player = Sprite.new(viewport)
    player.bitmap = RPG::Cache.picture(graphic[2])
    player.opacity = 0
    player.ox = player.bitmap.width / 2
    player.oy = player.bitmap.height / 2
    player.x = pictureBird.x
    player.y = pictureBird.y
    @@bird_with_player_frames = 0
    loop do
      pbUpdateSceneMap
      if pictureBird.x > (@@width / 2 + 10)
        pictureBird.x -= (@@width + pictureBird.bitmap.width - @@width / 2) / @@time_fly
        pictureBird.y -= (@@height / 4 - @@height / 2) / @@time_fly
        player.x = pictureBird.x
        player.y = pictureBird.y
        player.opacity = 0
        pictureBird.opacity = 255
      elsif pictureBird.x <= (@@width / 2 + 10) && pictureBird.x >= 0
        pictureBird.x -= (@@width + pictureBird.bitmap.width - @@width / 2) / @@time_fly
        pictureBird.y += (@@height / 4 - @@height / 2) / @@time_fly
        $game_player.opacity = 0
        player.x = pictureBird.x
        player.y = pictureBird.y
        player.zoom_x += @@zoom_increase_value
        player.zoom_y += @@zoom_increase_value
        @@bird_with_player_frames += 1
        player.opacity = 255
        pictureBird.opacity = 0
      else
        break
      end
      Graphics.update
    end
    pictureBird.dispose
    player.dispose
    viewport.dispose

    return true
  end

  def self.landing()
    graphic = CHARACTER_PLAYER[$player.character_ID - 1]

    # Player riding the bird animation
    viewport = Viewport.new(0, 0, @@width, @@height)
    viewport.z = 999999
    pictureBird = Sprite.new(viewport)
    pictureBird.bitmap = RPG::Cache.picture(@@character_bird)
    pictureBird.ox = pictureBird.bitmap.width / 2
    pictureBird.oy = pictureBird.bitmap.height / 2
    pictureBird.x  = @@width + pictureBird.bitmap.width
    pictureBird.y  = @@height / 4
    pictureBird.zoom_x += @@zoom_increase_value * @@bird_with_player_frames
    pictureBird.zoom_y += @@zoom_increase_value * @@bird_with_player_frames
    player = Sprite.new(viewport)
    player.bitmap = RPG::Cache.picture(graphic[3])
    player.opacity = 0
    player.ox = player.bitmap.width / 2
    player.oy = player.bitmap.height / 2
    player.x = pictureBird.x
    player.y = pictureBird.y
    loop do
      pbUpdateSceneMap
      if pictureBird.x > (@@width / 2 + 10)
        pictureBird.x -= (@@width + pictureBird.bitmap.width - @@width / 2) / @@time_fly
        pictureBird.y -= (@@height / 4 - @@height / 2) / @@time_fly
        player.x = pictureBird.x
        player.y = pictureBird.y
        if @@bird_with_player_frames > 0
          pictureBird.zoom_x -= @@zoom_increase_value
          pictureBird.zoom_y -= @@zoom_increase_value
          player.zoom_x = pictureBird.zoom_x
          player.zoom_y = pictureBird.zoom_y
          @@bird_with_player_frames -= 1
        end
        player.opacity = 255
        pictureBird.opacity = 0
      elsif pictureBird.x <= (@@width / 2 + 10) && pictureBird.x >= 0
        pictureBird.x -= (@@width + pictureBird.bitmap.width - @@width / 2) / @@time_fly
        pictureBird.y += (@@height / 4 - @@height / 2) / @@time_fly
        $game_player.opacity = 255
        player.x = pictureBird.x
        player.y = pictureBird.y
        player.opacity = 0
        pictureBird.opacity = 255
      else
        break
      end
      Graphics.update
    end
    pictureBird.dispose
    player.dispose
    viewport.dispose
    pbWait(8)

    # Player showing the pokéball
		$game_player.turn_up
		$game_player.character_name = pbGetPlayerCharset(graphic[0])
		pbWait(6)
    $game_player.turn_down
    pbWait(4)
    $game_player.turn_left
    pbWait(4)
    $game_player.turn_right
    pbWait(4)
    $game_player.turn_up
    pbWait(6)
    $game_player.character_name = pbGetPlayerCharset(graphic[1])
    pbWait(4)

    # Bird flying into the pokéball
		viewport = Viewport.new(0, 0, @@width, @@height)
		viewport.z = 999999
		sprite = {}
		sprite[@@character_bird] = Sprite.new(viewport)
		sprite[@@character_bird].bitmap = RPG::Cache.picture(@@character_bird)
		sprite[@@character_bird].ox = sprite[@@character_bird].bitmap.width / 2
		sprite[@@character_bird].oy = sprite[@@character_bird].bitmap.height / 2
		sprite[@@character_bird].x  = @@width / 2 + 16
		sprite[@@character_bird].y  = -sprite[@@character_bird].oy
		sprite[@@character_bird].angle = 90
		time = 2
		value = 5.to_f
		distance = (@@height / 2 + sprite[@@character_bird].oy).to_f
		zoom = (value.to_f * time) / distance
		loop do
			Graphics.update
			pbUpdateSpriteHash(sprite)
      sprite[@@character_bird].y += value * time
      sprite[@@character_bird].zoom_x -= zoom
      sprite[@@character_bird].zoom_y -= zoom
      if sprite[@@character_bird].y >= @@height / 2
        sprite[@@character_bird].zoom_x = 0
        sprite[@@character_bird].zoom_y = 0
        break
      end
		end
		pbDisposeSpriteHash(sprite)
		viewport.dispose

    # Player hiding the pokéball
		$game_player.character_name = pbGetPlayerCharset(graphic[0])
		pbWait(6)
    $game_player.turn_up
    pbWait(4)
    $game_player.turn_right
    pbWait(4)
    $game_player.turn_left
    pbWait(4)
    $game_player.turn_down
    pbWait(4)
    $game_player.refresh_charset
    pbWait(6)

    return true
  end
end
