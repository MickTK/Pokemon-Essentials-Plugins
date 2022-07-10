def CMD()
	quit = [
		"exit\n",
		"ext\n",
		"quit\n",
		"esc\n",
		"escape\n"
	]
	while true
		input = gets
		return if quit.include?(input.downcase)
		system(input)
	end
end
