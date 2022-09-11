# frozen_string_literal: true

# A subclass of Piece
class Queen < Piece
  def symbol
    "\u265B"
  end

  def fen_char
    color == :white ? 'Q' : 'q'
  end

  def self.represented_by?(string)
    %w[q Q].include?(string)
  end

  private

  def move_types
    [MoveTypes::CARDINAL_MOVEMENT, MoveTypes::DIAGONAL_MOVEMENT]
  end
end
