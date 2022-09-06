#===============================================================================
# Sprite_SurfBase
#===============================================================================
class Sprite_SurfBase
	alias fly_animation_update update
	def update
		return if disposed?
		if $PokemonGlobal.surfing || $PokemonGlobal.diving
			if @sprite && !@sprite.disposed?
				@sprite.src_rect.x = 0
				@sprite.src_rect.y = 0
			end
			return
		end
		fly_animation_update
	end
end
