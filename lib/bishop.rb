# frozen_string_literal: true

# A subclass of Piece
class Bishop < Piece
  def symbol
    "\u265D"
  end

  def fen_char
    color == :white ? 'B' : 'b'
  end

  def self.represented_by?(string)
    %w[b B].include?(string)
  end

  private

  def move_types
    [MoveTypes::DIAGONAL_MOVEMENT]
  end
end
