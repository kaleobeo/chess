# frozen_string_literal: true

# A null object for Pieces, a replacement for nil, when there is no real piece to be interacted with.
class NullPiece < Piece
  def to_s
    '   '
  end

  def initialize(_color = nil, _pos = nil, *_args)
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
