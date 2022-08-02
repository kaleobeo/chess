# frozen_string_literal: true

class Knight < Piece
  def symbol
    "\u265E"
  end

  def self.represented_by?(string)
    %w[n N].include?(string)
  end

  private

  def move_types
    [MoveTypes::KNIGHT_MOVEMENT]
  end
end