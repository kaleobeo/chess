class NullPiece < Piece
  def to_s
    '   '
  end

  def initialize(color = nil, pos = nil, *args)
    @color = nil
    @pos = nil
  end

  def self.represented_by?(_string)
    true
  end

  def fen_char
    '*'
  end

  def moves
    []
  end

  def friendly_to?(_attacker)
    false
  end
end