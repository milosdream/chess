require_relative 'piece'
require "byebug"

class Board
  attr_reader :grid

  # Array of class constants
  SKILL_PIECES = [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]

  sliding_p = SlidingPiece
  def initialize
      @grid = Array.new(8) {Array.new(8)}
      populate
  end

  def populate
    @grid[1].each_index do |j|
      @grid[1][j] = Pawn.new(:white, [1, j])
    end

    @grid[0].each_index do |j|
      @grid[0][j] = SKILL_PIECES[j].new(:white, [0, j])
    end

    @grid[6].each_index do |j|
      @grid[6][j] = Pawn.new(:black, [6, j])
    end

    @grid[7].each_index do |j|
      @grid[7][j] = SKILL_PIECES.reverse[j].new(:black, [7, j])
    end
  end

  def move(start_pos, end_pos)
    curr_piece = self[start_pos]
    raise "no piece here!" if curr_piece.nil?
    # raise "can't move here!" if curr_piece.valid_moves.include?(end_pos)
    self[end_pos] = curr_piece
    self[start_pos] = nil
  end

  def valid_moves
  end


  def [](position)
    @grid[position.first][position.last]
  end

  def []=(position, value)
    @grid[position.first][position.last] = value
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end
end
