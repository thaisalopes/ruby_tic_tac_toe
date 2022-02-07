class Game
  attr_reader :turn, :current_player
  def initialize (player1,player2)
    @game_board = Board.new
    @player1 = player1
    @player2 = player2
    @turn = 1
    @current_player = player1
    @streak = Streak.new
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
    if @game_board.spaces[position.to_i-1] != " "
      puts "This one is already taken, please choose another one"
    else 
      @game_board.write_on_board(@current_player,position)
    puts @game_board.show_board
    manage_turns
    end
  end

  def full_game
    @game_board.show_initial_board
    while over == false
      round
    end
    if @type_of_victory == "TIE"
      announce_tie
    else
      announce_winner
    end
  end

  def announce_winner
    puts "Congratulations, #{@winner}! You won the game."
  end

  def announce_tie
    puts "It's a tie!"
  end

  def over
    if @game_board.spaces.all?{ |value| value != " " }
      @type_of_victory = "TIE"
      return true
    end
    case @streak.check_victory(@game_board.spaces)
    when ""
      false
    when "X"
      @winner = @player1.name
      true
    when "O"
      @winner = @player2.name
      true
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
  attr_reader :spaces
  def initialize
    @spaces = Array.new(9," ")
  end

  def show_initial_board
    puts "|1|2|3|"+
    "\n|4|5|6|"+
    "\n|7|8|9|"+
    "\nChoose the position according to the space number"
  end

  def show_board
    "|#{@spaces[0]}|#{@spaces[1]}|#{@spaces[2]}|" + 
    "\n|#{@spaces[3]}|#{@spaces[4]}|#{@spaces[5]}|" +
    "\n|#{@spaces[6]}|#{@spaces[7]}|#{@spaces[8]}|"
  end

  def write_on_board (player, position)
    @spaces[position.to_i-1] = player.marker_type
  end
end  

class Streak
  def initialize
    @streaks = [[0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [3,5,8],
    [0,4,8],
    [2,4,6]]
  end

  def check_victory(spaces)
    @streaks.each do |streak| 
      space1 = spaces[streak[0]]
      space2 = spaces[streak[1]]
      space3 = spaces[streak[2]]
      victory_check_array = [space1,space2,space3]
      next if victory_check_array.any?(" ")    
      if victory_check_array.uniq.size == 1
        return victory_check_array.uniq.join
      end
    end
    return ""
  end
end

puts "Please enter Player 1's name"
player1_name = gets.chomp
puts "Please enter Player 2's name"
player2_name = gets.chomp

player1 = Player.new(player1_name,"X")
player2 = Player.new(player2_name, "O")

new_game = Game.new(player1,player2)


