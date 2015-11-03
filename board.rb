require_relative 'piece'
require "byebug"
require_relative 'error'

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
      @grid[1][j] = Pawn.new(:black, [1, j])
    end

    @grid[0].each_index do |j|
      @grid[0][j] = SKILL_PIECES[j].new(:black, [0, j])
    end

    @grid[6].each_index do |j|
      @grid[6][j] = Pawn.new(:white, [6, j])
    end

    @grid[7].each_index do |j|
      @grid[7][j] = SKILL_PIECES.reverse[j].new(:white, [7, j])
    end
  end

  def move(start_pos, end_pos)
    curr_space = self[start_pos]
    future_space = self[end_pos]
    if curr_space.nil?
      raise MoveError.new "no piece here!"
    end

    unless curr_space.possible_moves.include?(end_pos)
      raise MoveError.new "not a valid move!"
    end

    if sliding_through?(start_pos, end_pos)
      raise MoveError.new "can't move through pieces!"
    end

    unless future_space.nil? || curr_space.color != future_space.color
      raise MoveError.new "spot occupied by your piece!"
    end

    unless valid_pawn_attack?(start_pos, end_pos)
      raise MoveError.new "Pawns only attack diagonally"
    end

    # if curr_space.move_into_check?(end_pos)
    #   raise MoveError.new "can't move here!"
    # end
    self[end_pos] = curr_space
    curr_space.pos = end_pos
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

    curr_piece = self[start_pos]
    return false unless curr_piece.is_a?(SlidingPiece)

    start_row, start_col  = start_pos
    end_row, end_col = end_pos

    possibles = curr_piece.possible_moves

    compare_row = start_row <=> end_row
    compare_col = start_col <=> end_col

    case compare_row
    when -1
      possibles.delete_if do |move|
        move.first <= start_row || move.first >= end_row
      end
    when 0
      possibles.delete_if { |move| move.first != start_row }
    when 1
      possibles.delete_if do |move|
        move.first >= start_row || move.first <= end_row
      end
    end

    case compare_col
    when -1
      possibles.delete_if do |move|
        move.last <= start_col || move.last >= end_col
      end
    when 0
      possibles.delete_if { |move| move.last != start_col }
    when 1
      possibles.delete_if do |move|
        move.last >= start_col || move.last <= end_col
      end
    end

    !possibles.all? { |move| self[move].nil? }
  end

  def move_into_check?
  end

  def valid_pawn_attack?(start_pos, end_pos)
    curr_piece = self[start_pos]
    return true unless curr_piece.is_a?(Pawn)

    start_row, start_col  = start_pos
    end_row, end_col = end_pos

    if end_col != start_col


  end


  def [](position)
    @grid[position.first][position.last]
  end

  def []=(position, value)
    @grid[position.first][position.last] = value
  end

end
