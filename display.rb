require 'colorize'
require_relative "cursorable"
require_relative 'piece'

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
  end

  def render
    system("clear")
    @board.grid.each_with_index do|row, i|
      row.each_with_index do |space, j|
        if [i, j] == @cursor_pos
          print charcter(space).blue
        else
          print charcter(space)
        end
        print " "
      end
      print "\n"
    end
  end

  def charcter(space)
    if space.nil?
      "_".yellow
    else
      space.to_s
    end
  end

  def prompt
    cursor_pos = [0, 0]
    result = nil
    until result
      render
      puts "pick a spot"
      result = get_input
    end
    result
  end


end
