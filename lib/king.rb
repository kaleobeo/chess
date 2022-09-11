# frozen_string_literal: true

# Subclass of Piece
class King < Piece
  def symbol
    "\u265A"
  end

  def fen_char
    color == :white ? 'K' : 'k'
  end

  def self.represented_by?(string)
    %w[k K].include?(string)
  end

  def move_types
    [MoveTypes::KING_MOVEMENT, MoveTypes::CASTLING]
  end
end
