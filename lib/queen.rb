# frozen_string_literal: true

class Queen < Piece
  def symbol
    "\u265B"
  end

  def self.represented_by?(string)
    %w[q Q].include?(string)
  end

  private

  def move_types
    [MoveTypes::CARDINAL_MOVEMENT, MoveTypes::DIAGONAL_MOVEMENT]
  end
end