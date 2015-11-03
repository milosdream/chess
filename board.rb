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
    raise "not a valid move!" unless curr_piece.possible_moves.include?(end_pos)
    # raise "can't move here!" unless nil || self[start_pos].color != self[end_pos].color
    raise "can't move through pieces!" if sliding_through?(start_pos, end_pos)
    # raise "can't move here!" if curr_piece.move_into_check?(end_pos)
    self[end_pos] = curr_piece
    curr_piece.pos = end_pos
    self[start_pos] = nil
  end

  def move!(start_pos, end_pos)
    curr_piece = self[start_pos]
    self[end_pos] = curr_piece
    curr_piece.pos = end_pos
    self[start_pos] = nil
  end

  def valid_moves

  end

  def sliding_through?(start_pos, end_pos)
    debugger

    curr_piece = self[start_pos]
    return false unless curr_piece.is_a?(SlidingPiece)

    start_row = start_pos.first
    start_col = start_pos.last
    end_row = end_pos.first
    end_col = end_pos.last

    possibles = curr_piece.possible_moves

    compare_row = start_row <=> end_row
    compare_col = start_col <=> end_col

    case compare_row
    when -1
      possibles.delete_if do |move|
        move.first <= start_row || move.first > end_row
      end
    when 0
      possibles.delete_if { |move| move.first != start_row }
    when 1
      possibles.delete_if do |move|
        move.first >= start_row || move.first < end_row
      end
    end

    case compare_col
    when -1
      possibles.delete_if do |move|
        move.last <= start_col || move.last > end_col
      end
    when 0
      possibles.delete_if { |move| move.last != start_col }
    when 1
      possibles.delete_if do |move|
        move.last >= start_col || move.last < end_col
      end
    end

    !possibles.all? { |move| self[move].nil? }
  end

  def move_into_check?
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
