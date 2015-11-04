require_relative 'board'
require_relative "cursorable"
require_relative "display"
require_relative 'piece'
require_relative 'error'

class Game
  def initialize#(player1, player2)
    @board = Board.new
    # @current_player, @waiting_player = player1, player2
    #
    # @current_player.color = :white
    # @waiting_player.color = :black
  end

  def play
    system("clear")
    puts "WELCOME TO CHESS!"
    sleep(1)
    play_turn until over?
  end

  def play_turn
    display = Display.new(@board)
    begin
      start_pos = display.prompt
      end_pos = display.prompt
      @board.move(start_pos, end_pos)
    rescue MoveError => e
      puts e.message
      sleep(1)
      retry
    end
    display.render
  end

  def switch_player
    @current_player, @waiting_player = @waiting_player, @current_player
  end

  def over?
    false
  end


end
