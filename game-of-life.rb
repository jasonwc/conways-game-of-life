# Instructions
class Controller
 
  def initialize
	  # initialize starter board
	  # the board is predetermined in this version but will be user selectable in the future
	  @board = [["X", "X", "O", "X", "O"],
              ["X", "O", "X", "O", "X"],
              ["O", "O", "O", "X", "X"],
              ["X", "X", "O", "X", "X"],
              ["O", "X", "O", "O", "X"]]
	  # the tracker is set to the same values as the board
	  @tracker = [["X", "X", "O", "X", "O"],
                ["X", "O", "X", "O", "X"],
                ["O", "O", "O", "X", "X"],
                ["X", "X", "O", "X", "X"],
                ["O", "X", "O", "O", "X"]]  
	  @counter = 0
	  # the @continue variable is set to true. This lets the loop continue until @continue is false
	  @continue = true
	  #Prints the initial board to the screen
	  update_board
	  while @continue do  
	    # Step 1: update the counter
		  counter
		  # Step 2: check to see if the cell lives or dies
		  check_alive
		  # Step 3: clear the terminal
		  system('clear')
		  # Step 4: Move the @tracker values to @board and print to the terminal
		  update_board
		  # Step 5: Wait one second so that the player can see the updated board
		  sleep(1)
		  # Step 6: Check to see if the game is over. If not, @continue stays true and the loop repeats
		  check_end
	  end
	  # Prints a message when the game ends and allows the player the option to play again
	  # For now, playing again is exactly the same, but eventually the player can choose custom board dimensions
	  end_message
  end

  def check_end
    # Set @continue to false
    @continue = false
    # Checks every row in the array
    @board.each do |row|
      # If just one of the arrays has a live cell, @continue is set back to true and the loop breaks, returning us back to the while loop in initialize
      # If there are no live cells at the end, @continue stays false, and the while loop in initialize finishes
      if row.include?("O")
        @continue = true
        break
      end
    end
  end

  def end_message
    # Displays how long the game lasted, asks if you want to play again
    puts "The game of life lasted #{@counter} ticks."
    puts "Would you like to play again? (y or n)"
    # Allows user to select yes or no
    input = gets.chomp
    if input == 'y'
            initialize
    elsif input == 'n'
            exit
    end
  end

  def update_board
    # clone tracker array to board array, prints the tick counter, and prints @board in a nice format  
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
    # these two loops go through every element in the @board array
    # they give us both the actually value in the array ('X' or 'O') and the coordinates (I.E. [0, 4])
    @board.each_with_index do |x, posx|
      x.each_with_index do |y, posy|
	      # we use cell to store the alive/dead state of the cell
	      # we use @alive and @dead to store the number of adjacent cells that are alive or dead
	      cell = y
	      @alive = 0
	      @dead = 0
	      # For each cell x, y, check all adjacent cells:
	      # x+1, y or right
	      check_surrounding(posx, posy, 1, 0)
	      # x, y+1 or top
	      check_surrounding(posx, posy, 0, 1)
	      # x+1, y+1 or top right
	      check_surrounding(posx, posy, 1, 1)
	      # x-1, y or left
	      check_surrounding(posx, posy, -1, 0)
	      # x, y-1 or bottom
	      check_surrounding(posx, posy, 0, -1)
	      # x-1, y-1 or bottom left
	      check_surrounding(posx, posy, -1, -1)
	      # x-1, y+1 or top left
	      check_surrounding(posx, posy, -1, 1)
	      # x+1, y-1 or bottom right
	      check_surrounding(posx, posy, 1, -1)
	      # Following all of the check_surrounding calls, we know exactly how many adjacent cells are alive or dead
	      # If the current cell is alive, then it must have either 2 or 3 alive cells around it to stay alive. Otherwise it dies
	      if cell == 'O'
        if @alive == 2 || @alive == 3
          live(posx,posy)
        else
          die(posx,posy)
        end
	      else
	      # if the cell is dead, then it has to have exactly 3 alive cells around it to 'resurrect'
	      if @alive == 3
	        live(posx,posy)
	      end
	      end
      end
    end
  end

  def check_surrounding(xpos, ypos, xmod, ymod)
	  # xpos and ypos are the x and y coordinates of the cells we are checking
	  # xmod and ymod are the modifiers to get to an adjacent cell
	  # I.E if we wish to evaluate the top left cell, the modifiers are xmod = -1 and ymod = 1
	  # we set x to be the x coordinate of the cell we are checking
	  x = xpos + xmod
	  # If the cell is on the edge of the grid and we add to it, it will return nil
	  # This is because arrays are indexed from 0
	  # If we pass in the coordinates for 0, 4 as the cell, adding 1 to 4 will become 5 which is outside the boundary of the array
	  # In this case, we manually set the value to be 0, so that instead of going outside the array, it jumps to the other side
	  if xpos + xmod == 5
      x = 0
	  end
	  y = ypos + ymod
	  if ypos + ymod == 5
      y = 0
	  end
	  # we then set the adj_sell we are evaluating to the x, y coordinates of its location on the array
	  # this tells us if the cell is alive or dead. If alive, we add 1 to the alive counter
	  # If dead, we add one to the dead counter
	  adj_cell = @board[x][y]
	  if adj_cell.include?('O') == true
      @alive += 1
	  else
      @dead += 1
	  end
  end

  def die(x,y)
  	# For cell x,y: change to dead ('X') on tracker array
    @tracker[x][y] = 'X'
  end
         
  def live(x,y)
    # For cell x,y: change to alive ('O') on tracker array
    @tracker[x][y] = 'O'
  end
end
 
# Interpretor
# Intialize an instance of Controller
controller = Controller.new
# Automatically calls the initialize method which runs the code