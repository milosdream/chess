require_relative "cursorable"

class Player
  attr_accessor :color
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
