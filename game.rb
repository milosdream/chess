require_relative 'board'
require_relative "cursorable"
require_relative "display"
require_relative 'piece'

class Game
  def initialize#(player1, player2)
    @board = Board.new
    # @current_player, @waiting_player = player1, player2
    #
    # @current_player.color = :white
    # @waiting_player.color = :black
  end

  def play
    play_turn until over?

  end

  def play_turn
    display = Display.new(@board)
    start_pos = display.prompt
    end_pos = display.prompt
    @board.move(start_pos, end_pos)
    Display.new(@board).render
  end

  def switch_playerd
    @current_player, @waiting_player = @waiting_player, @current_player
  end



end
