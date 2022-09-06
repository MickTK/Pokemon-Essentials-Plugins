# Draw egg group(s) in the summary
if MoreBreedingStuff::SHOW_EGG_GROUPS_IN_SUMMARY
  class PokemonSummary_Scene
    def drawPageOne
      @sprites["background"].setBitmap(MoreBreedingStuff::SUMMARY_SCREEN_PATH)
      overlay = @sprites["overlay"].bitmap
      base   = Color.new(248, 248, 248)
      shadow = Color.new(104, 104, 104)
      dexNumBase   = (@pokemon.shiny?) ? Color.new(248, 56, 32) : Color.new(64, 64, 64)
      dexNumShadow = (@pokemon.shiny?) ? Color.new(224, 152, 144) : Color.new(176, 176, 176)
      # If a Shadow Pokémon, draw the heart gauge area and bar
      if @pokemon.shadowPokemon?
        shadowfract = @pokemon.heart_gauge.to_f / @pokemon.max_gauge_size
        imagepos = [
          ["Graphics/Pictures/Summary/overlay_shadow", 224, 240],
          ["Graphics/Pictures/Summary/overlay_shadowbar", 242, 280, 0, 0, (shadowfract * 248).floor, -1]
        ]
        pbDrawImagePositions(overlay, imagepos)
      end
      # Write various bits of text
      textpos = [
        [_INTL("Dex No."), 238, 86, 0, base, shadow],
        [_INTL("Species"), 238, 118, 0, base, shadow],
        [@pokemon.speciesName, 435, 118, 2, Color.new(64, 64, 64), Color.new(176, 176, 176)],
        [_INTL("Type"), 238, 150, 0, base, shadow],
        [_INTL("Egg Group"), 238, 182, 0, base, shadow], # TK
        [_INTL("OT"), 238, 214, 0, base, shadow],
      ]
      textpos.push([_INTL("ID No."), 238, 246, 0, base, shadow]) if !@pokemon.shadowPokemon? # TK
      # Write the Regional/National Dex number
      dexnum = 0
      dexnumshift = false
      if $player.pokedex.unlocked?(-1)   # National Dex is unlocked
        dexnum = @nationalDexList.index(@pokemon.species_data.species) || 0
        dexnumshift = true if Settings::DEXES_WITH_OFFSETS.include?(-1)
      else
        ($player.pokedex.dexes_count - 1).times do |i|
          next if !$player.pokedex.unlocked?(i)
          num = pbGetRegionalNumber(i, @pokemon.species)
          next if num <= 0
          dexnum = num
          dexnumshift = true if Settings::DEXES_WITH_OFFSETS.include?(i)
          break
        end
      end
      if dexnum <= 0
        textpos.push(["???", 435, 86, 2, dexNumBase, dexNumShadow])
      else
        dexnum -= 1 if dexnumshift
        textpos.push([sprintf("%03d", dexnum), 435, 86, 2, dexNumBase, dexNumShadow])
      end
      # Write Original Trainer's name and ID number
      if @pokemon.owner.name.empty?
        textpos.push([_INTL("RENTAL"), 435, 214, 2, Color.new(64, 64, 64), Color.new(176, 176, 176)])
        textpos.push(["?????", 435, 246, 2, Color.new(64, 64, 64), Color.new(176, 176, 176)]) if !@pokemon.shadowPokemon? # TK
      else
        ownerbase   = Color.new(64, 64, 64)
        ownershadow = Color.new(176, 176, 176)
        case @pokemon.owner.gender
        when 0
          ownerbase = Color.new(24, 112, 216)
          ownershadow = Color.new(136, 168, 208)
        when 1
          ownerbase = Color.new(248, 56, 32)
          ownershadow = Color.new(224, 152, 144)
        end
        textpos.push([@pokemon.owner.name, 435, 214, 2, ownerbase, ownershadow])
        textpos.push([sprintf("%05d", @pokemon.owner.public_id), 435, 246, 2,
                      Color.new(64, 64, 64), Color.new(176, 176, 176)]) if !@pokemon.shadowPokemon? # TK
      end
      # Write Exp text OR heart gauge message (if a Shadow Pokémon)
      if @pokemon.shadowPokemon?
        textpos.push([_INTL("Heart Gauge"), 238, 246, 0, base, shadow])
        heartmessage = [_INTL("The door to its heart is open! Undo the final lock!"),
                        _INTL("The door to its heart is almost fully open."),
                        _INTL("The door to its heart is nearly open."),
                        _INTL("The door to its heart is opening wider."),
                        _INTL("The door to its heart is opening up."),
                        _INTL("The door to its heart is tightly shut.")][@pokemon.heartStage]
        memo = sprintf("<c3=404040,B0B0B0>%s\n", heartmessage)
        drawFormattedTextEx(overlay, 234, 308, 264, memo)
      else
        endexp = @pokemon.growth_rate.minimum_exp_for_level(@pokemon.level + 1)
        textpos.push([_INTL("Exp. Points"), 238, 310, 0, base, shadow])
        textpos.push([@pokemon.exp.to_s_formatted, 488, 310, 1, Color.new(64, 64, 64), Color.new(176, 176, 176)])
        textpos.push([_INTL("To Next Lv."), 238, 342, 0, base, shadow])
        textpos.push([(endexp - @pokemon.exp).to_s_formatted, 488, 342, 1, Color.new(64, 64, 64), Color.new(176, 176, 176)])
      end
      # Draw all text
      pbDrawTextPositions(overlay, textpos)
      # Draw Pokémon type(s)
      @pokemon.types.each_with_index do |type, i|
        type_number = GameData::Type.get(type).icon_position
        type_rect = Rect.new(0, type_number * 28, 64, 28)
        type_x = (@pokemon.types.length == 1) ? 402 : 370 + (66 * i)
        overlay.blt(type_x, 146, @typebitmap.bitmap, type_rect)
      end
      # Draw Pokémon egg group(s) TK
      species_data = GameData::Species.get_species_form(@pokemon.species, @pokemon.form)
      overlay = @sprites["overlay"].bitmap
      x = species_data.egg_groups.length > 1 ? 369 : 403
      y = 177
      space = 4
      species_data.egg_groups.each_with_index do |group, i|
        egg_rect = Rect.new(0, MoreBreedingStuff::ICON_LIST.index(group) * MoreBreedingStuff::ICON_HEIGHT, MoreBreedingStuff::ICON_WIDTH, MoreBreedingStuff::ICON_HEIGHT)
        overlay.blt(x + ((MoreBreedingStuff::ICON_WIDTH + space) * i), y, MoreBreedingStuff::EGG_GROUP_BITMAP.bitmap, egg_rect)
      end
      # Draw Exp bar
      if @pokemon.level < GameData::GrowthRate.max_level
        w = @pokemon.exp_fraction * 128
        w = ((w / 2).round) * 2
        pbDrawImagePositions(overlay,
                            [["Graphics/Pictures/Summary/overlay_exp", 362, 372, 0, 0, w, 6]])
      end
    end
  end
end
