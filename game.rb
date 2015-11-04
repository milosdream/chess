require_relative 'board'
require_relative "cursorable"
require_relative "display"
require_relative 'piece'
require_relative 'error'
require_relative 'player'

class Game
  def initialize(player1, player2)
    @board = Board.new
    @current_player, @waiting_player = player1, player2

    @current_player.color = :white
    @waiting_player.color = :black
  end

  def play
    play_turn until @board.checkmate?(@current_player.color)

    puts "Congrats #{@waiting_player.name} is the winner!"
    sleep(1)
    puts "#{@current_player.name} you suck!!"
  end

  def play_turn
    display = Display.new(@board)
    begin
      start_pos = display.prompt
      end_pos = display.prompt
      @board.move(start_pos, end_pos, @current_player.color)
    rescue MoveError => e
      puts e.message
      sleep(1)
      retry
    end
    display.render
    switch_player
  end

  def switch_player
    @current_player, @waiting_player = @waiting_player, @current_player
  end

  def over?
    false
  end

end

if __FILE__ == $PROGRAM_NAME
  system("clear")
  puts "Welcome to CHESS!"
  sleep(1)
  puts "Input Player 1's name"
  name1 = gets.chomp
  puts "Input Player 2's name"
  name2 = gets.chomp

  player1 = Player.new(name1)
  player2 = Player.new(name2)
  game = Game.new(player1, player2)
  game.play
end
