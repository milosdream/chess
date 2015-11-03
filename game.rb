require_relative 'board'
require_relative "cursorable"
require_relative "display"
require_relative 'piece'

class Game
  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
  end






end
