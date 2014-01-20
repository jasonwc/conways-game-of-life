# Instructions 
class Controller 

	def initialize 
		# initialize random board to start 
		@board = [["X", "X", "O", "X", "O"], 
				  	  ["X", "O", "X", "O", "X"], 
		  		    ["O", "O", "O", "X", "X"], 
		  		    ["X", "X", "O", "X", "X"], 
		  		    ["O", "X", "O", "O", "X"]] 
		@tracker = [["X", "X", "O", "X", "O"], 
				  	  ["X", "O", "X", "O", "X"], 
		  		    ["O", "O", "O", "X", "X"], 
		  		    ["X", "X", "O", "X", "X"], 
		  		    ["O", "X", "O", "O", "X"]]  
		@counter = 0 
		@continue = true 
		update_board 
		while @continue do  
  		counter 
  		check_alive
  		system('clear')
  		update_board
  		sleep(1)
  		check_end 
		end 
		end_message 
	end 

	def check_end
		@continue = false
		@board.each do |row|
			if row.include?("O")
				@continue = true
				break
			end
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
		@tracker.each_with_index do |row, i|
			@board[i] = row.clone
		end
		puts "Tick: #{@counter}"
		@board.each do 
			|r| puts r.map { |p| p }.join(" ") 
		end 
	end 

	def counter 
		# Update tick counter 
		@counter += 1 
	end 

	def check_alive 
		@board.each_with_index do |x, posx| 
			x.each_with_index do |y, posy| 
				puts "element [#{posx}, #{posy}] is #{y}"
				#@tracker.each do 
				#	|r| puts r.map { |p| p }.join(" ") 
				#end 
				cell = y
				@alive = 0
				@dead = 0
				# For each cell x, y, check alive or dead, check adjacent:
				# x+1, y 
				check_surrounding(posx, posy, 1, 0)
				check_surrounding(posx, posy, 0, 1)
				check_surrounding(posx, posy, 1, 1)
				check_surrounding(posx, posy, -1, 0)
				check_surrounding(posx, posy, 0, -1)
				check_surrounding(posx, posy, -1, -1)
				check_surrounding(posx, posy, -1, 1)
				check_surrounding(posx, posy, 1, -1)
				#puts "Alive: #{@alive} Dead: #{@dead}"
				if cell == 'O'
					if @alive == 2 || @alive == 3
						live(posx,posy)
					else
						die(posx,posy)
					end
				else
					if @alive == 3
						live(posx,posy)
					end
				end
			end
		end
	end

		# if live = two or three live adjacent, live method # else die method 
		# if dead = three live adjacent, live method # else die method end 
	def check_surrounding(xpos, ypos, xmod, ymod)
		x = xpos + xmod
		if xpos + xmod == 5
			x = 0
		end
		y = ypos + ymod
		if ypos + ymod == 5
			y = 0
		end
		adj_cell = @board[x][y]
		if adj_cell.include?('O') == true
			@alive += 1
		else 
			@dead += 1
		end
	end



	def die(x,y) 
		# For cell x,y: change to dead (X) on tracker array 
		@tracker[x][y] = 'X'
		#puts "Die" 
	end 
		
	def live(x,y) 
		# For cell x,y: change to alive (O) on tracker array 
		@tracker[x][y] = 'O' 
		#puts "Live"
	end 
end 

# Interpretor 
# Intialize an instance of Controller 
controller = Controller.new 
# Automatically calls the initialize method which runs the code