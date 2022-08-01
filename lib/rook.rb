# frozen_string_literal: true

class Rook < Piece
  def self.represented_by?(string)
    %w[r R].include?(string)
  end

  private

  def move_types
    [MoveTypes::CARDINAL_MOVEMENT]
  end
end