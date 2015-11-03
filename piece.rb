require 'colorize'
class Piece

  def initialize(color, pos)
    @color, @pos = color, pos
  end

  def to_s
    if @color == :white
      @type.to_s.red
    elsif @color == :black
      @type.to_s.green
    end
  end
end

class SlidingPiece < Piece

end

class SteppingPiece < Piece

end

class Rook < SlidingPiece
  def initialize(color, pos)
    @type = :R
    super
  end
end

class Knight < SteppingPiece
  def initialize(color, pos)
    @type = :k
    super
  end
end

class Bishop < SlidingPiece
  def initialize(color, pos)
    @type = :B
    super
  end
end

class Queen < SlidingPiece
  def initialize(color, pos)
    @type = :Q
    super
  end
end

class King < SteppingPiece
  def initialize(color, pos)
    @type = :K
    super
  end
end

class Pawn < Piece
  def initialize(color, pos)
    @type = :P
    super
  end
end
