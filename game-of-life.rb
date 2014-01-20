# Instructions 
class Controller 

	def initialize 
		# initialize random board to start 
		@board = [["X", "O", "O", "O", "X"], 
				  	  ["O", "X", "X", "X", "O"], 
		  		    ["O", "O", "O", "O", "X"], 
		  		    ["X", "O", "X", "O", "O"], 
		  		    ["O", "O", "O", "X", "O"]] 
		@tracker = @board 
		@counter = 0 
		@continue = true 
		update_board 
		while @continue do 
			puts "Tick: #{@counter}" 
  		counter 
  		check_alive 
  		update_board 
  		check_end 
		end 
		end_message 
	end 

	def check_end 
		alive = @board.include?('O') 
		if alive == false 
			@continue = false 
		end 
	end 

	def end_message 
		# Outputs counter, asks if you want to play again 
		puts "The game of life lasted #{@counter} ticks." 
		puts "Would you like to play again? (y or n)" 
		input = gets.chomp 
		if input == 'y' 
			initialize 
		elsif input == 'n' 
			exit 
		end 
	end 

	def update_board 
		# clone tracker array to board array, prints the board in a nice format 
		@board = @tracker 
		@board.each do 
			|r| puts r.map { |p| p }.join(" ") 
		end 
	end 

	def counter 
		# Update tick counter 
		@counter = @counter + 1 
	end 

	def check_alive 
		@board.each_with_index do |x, posx| 
			x.each_with_index do |y, posy| 
				puts "element [#{posx}, #{posy}] is #{y}"
				#@tracker.each do 
				#	|r| puts r.map { |p| p }.join(" ") 
				#end 
				cell = y
				alive = 0
				dead = 0
				# For each cell x, y, check alive or dead, check adjacent:
				# x+1, y 

				if posx == 4
					right_center = @board[0][posy]
				else
					right_center = @board[posx + 1][posy]
				end
				if right_center.include?('O') == true
					alive = alive + 1
				else
					dead = dead + 1
				end
				# x-1, y 
				left_center = @board[posx - 1][posy]
				if left_center.include?('O') == true
					alive = alive + 1
				else
					dead = dead + 1
				end
				# x, y+1 
				middle_top = @board[posx][posy + 1]
				if middle_top.include?('O') == true
					alive = alive + 1
				else
					dead = dead + 1
				end
				# x, y-1
				middle_bottom = @board[posx][posy - 1]
				if middle_bottom.include?('O') == true
					alive = alive + 1
				else
					dead = dead + 1
				end
				# x+1, y+1
				if posx == 4
					right_top = @board[0][posy + 1]
				else
					right_top = @board[posx + 1][posy + 1]
				end
				if right_top.include?('O') == true
					alive = alive + 1
				else
					dead = dead + 1
				end
				# x+1, y-1
				if posx == 4
					right_bottom = @board[0][posy - 1]
				else
					right_bottom = @board[posx + 1][posy - 1]
				end
				if right_bottom.include?('O') == true
					alive = alive + 1
				else
					dead = dead + 1
				end
				# x-1, y+1
				left_top = @board[posx - 1][posy + 1]
				if left_top.include?('O') == true
					alive = alive + 1
				else
					dead = dead + 1
				end
				# x-1, y-1
				left_bottom = @board[posx - 1][posy - 1]
				if left_bottom.include?('O') == true
					alive = alive + 1
				else
					dead = dead + 1
				end
				if cell == 1
					if alive == 2 || alive == 3
						live(posx,posy)
					else
						die(posx,posy)
					end
				else
					if alive == 3
						live(posx,posy)
					end
				end
			end
		end
	end
		# if live = two or three live adjacent, live method # else die method 
		# if dead = three live adjacent, live method # else die method end 
	def die(x,y) 
		# For cell x,y: change to dead (0) on tracker array 
		@tracker[x][y] = 'X' 
	end 
		
	def live(x,y) 
		# For cell x,y: change to alive (1) on tracker array 
		@tracker[x][y] = 'O' 
	end 
end 

# Interpretor 
# Intialize an instance of Controller 
controller = Controller.new 
# Automatically calls the initialize method which runs the code