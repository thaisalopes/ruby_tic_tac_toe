class Game
  attr_reader :turn, :current_player
  def initialize (player1,player2)
    @game_board = Board.new
    @player1 = player1
    @player2 = player2
    @turn = 1
    @current_player = player1
    @end = false
    full_game
  end

  def manage_turns
    if @turn%2 == 0
      @current_player = @player1
    else
      @current_player = @player2
    end
    @turn +=1
  end

  def round
    puts "#{@current_player.name}, where would you like to put a marker?"
    position = gets.chomp
    @game_board.write_on_board(@current_player,position)
    puts @game_board.show_board
    manage_turns
  end

  def full_game
    while @end == false
      round
    end
  end
end

class Player
  attr_reader :name, :marker_type
  def initialize(name,marker_type)
    @name = name
    @marker_type = marker_type
  end
end

class Board
  def initialize
    @space = Array.new(9,"")
  end

  def show_board
    "|#{@space[0]}|#{@space[1]}|#{@space[2]}|" + 
    "\n|#{@space[3]}|#{@space[4]}|#{@space[5]}|" +
    "\n|#{@space[6]}|#{@space[7]}|#{@space[8]}|"
  end

  def write_on_board (player, position)
    @space[position.to_i-1] = player.marker_type
  end
end  

puts "Please enter Player 1's name"
player1_name = gets.chomp
puts "Please enter Player 2's name"
player2_name = gets.chomp

player1 = Player.new(player1_name,"X")
player2 = Player.new(player2_name, "O")

puts "Player 1 = #{player1.name}"
puts "Player 2 = #{player2.name}"



new_game = Game.new(player1,player2)


