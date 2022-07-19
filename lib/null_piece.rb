class NullPiece < Piece
  def initialize(color = nil, pos = nil, *args)
    @color = nil
    @pos = nil
  end

  def self.represented_by?(_string)
    true
  end

  def moves
    []
  end

  def friendly_to?(_attacker)
    false
  end
end