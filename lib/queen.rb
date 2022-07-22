# frozen_string_literal: true

class Queen < Piece
  def self.represented_by?(string)
    %w[q Q].include?(string)
  end

  private

  def move_types
    [Move::CARDINAL_MOVEMENT, Move::DIAGONAL_MOVEMENT]
  end
end