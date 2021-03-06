require 'colorize'
class Piece

  attr_accessor :pos
  attr_reader :color

  def initialize(color, pos)
    @color, @pos = color, pos
  end

  def to_s
    if @color == :white
      @type.to_s.green
    elsif @color == :black
      @type.to_s.red
    end
  end

  def off_board?(position)
    !position.all? { |idx| idx.between?(0,7) }
  end
end

class SlidingPiece < Piece

  def diagonals
    row = @pos.first
    col = @pos.last
    possibles = []

    (0..7).each do |i|
      diagonals = [
        [row + i, col + i],
        [row - i, col - i],
        [row + i, col - i],
        [row - i, col + i]
      ]

      diagonals.each do |new_pos|
        possibles << new_pos unless off_board?(new_pos)
      end
    end
    possibles.delete(@pos)
    possibles
  end

  def orthogonals
    row = @pos.first
    col = @pos.last
    possibles = []
    (0..7).each do |i|
      possibles << [row, i]
      possibles << [i, col]
    end
    possibles.delete(@pos)
    possibles
  end
end

class Rook < SlidingPiece
  def initialize(color, pos)
    @type = :R
    super
  end

  def possible_moves
    orthogonals
  end

end

class Knight < Piece
  def initialize(color, pos)
    @type = :k
    super
  end

  def possible_moves
    possibles = []
    row = @pos.first
    col = @pos.last

    knight_steps = [
      [row + 2, col + 1],
      [row + 2, col - 1],
      [row + 1, col + 2],
      [row + 1, col - 2],
      [row - 2, col + 1],
      [row - 2, col - 1],
      [row - 1, col + 2],
      [row - 1, col - 2]
    ]

    knight_steps.each do |new_pos|
      possibles << new_pos unless off_board?(new_pos)
    end
    possibles.delete(@pos)
    possibles
  end
end

class Bishop < SlidingPiece
  def initialize(color, pos)
    @type = :B
    super
  end

  def possible_moves
    diagonals
  end
end

class Queen < SlidingPiece
  def initialize(color, pos)
    @type = :Q
    super
  end

  def possible_moves
    orthogonals + diagonals
  end
end

class King < Piece
  def initialize(color, pos)
    @type = :K
    super
  end

  def possible_moves
    possibles = []
    row = @pos.first
    col = @pos.last

    (-1..1).each do |i|
      (-1..1).each do |j|
        new_pos = [row + i, col + j]
        possibles << new_pos unless off_board?(new_pos)
      end
    end
    possibles.delete(@pos)
    possibles
  end
end

class Pawn < Piece
  def initialize(color, pos)
    @type = :P
    super
  end

  def possible_moves
    row_travels = 1 if @color == :black
    row_travels = -1 if @color == :white
    row = @pos.first
    col = @pos.last
    possibles = []

    (-1..1).each do |j|
      new_pos = [row + row_travels, col + j]
      possibles << new_pos unless off_board?(new_pos)
    end

    if pos.first == 1 || pos.first == 6
      new_pos = [row + (row_travels * 2), col]
      possibles << new_pos unless off_board?(new_pos)
    end

    possibles
  end
end
