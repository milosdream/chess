require_relative 'piece'

class Board
  attr_reader :grid

  def initialize
      @grid = Array.new(8) {Array.new(8)}
      populate
  end

  def populate
    @grid[0].each do |space|
      space = Piece.new
    end
  end

  def move(start_pos, end_pos)
    curr_piece = self[start_pos]
    raise "no piece here!" if curr_piece.nil?
    raise "can't move here!" if curr_piece.valid_moves.include?(end_pos)
    self[end_pos] = curr_piece
    curr_piece = nil

  end

  def [](position)
    @grid[position.first][position.last]
  end

  def []=(position, value)
    @grid[position.first][position.last] = value
  end
end
