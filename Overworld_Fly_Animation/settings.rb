class OverworldFlyAnimation
  
  # List of characters in the game
  CHARACTER_PLAYER = [
    # Boy (default)
    [
      "boy_show_pokeball_0",  # "Graphics/Characters/"
      "boy_show_pokeball_1",  # "Graphics/Characters/"
      "flyBirdBoyFront",      # "Graphics/Pictures/"
      "flyBirdBoyBack"        # "Graphics/Pictures/"
    ],
    # Girl (default)
    [
      "girl_show_pokeball_0", # "Graphics/Characters/"
      "girl_show_pokeball_1", # "Graphics/Characters/"
      "flyBirdGirlFront",     # "Graphics/Pictures/"
      "flyBirdGirlBack"       # "Graphics/Pictures/"
    ]
  ]

  @@character_bird = "flyBird" # Bird character "Graphics/Pictures/"
  @@se_bird = "Fly bird"       # Bird sound effect "Audio/SE/"
end
