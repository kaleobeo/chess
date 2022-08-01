# frozen_string_literal: true

class King < Piece
  def self.represented_by?(string)
    %w[k K].include?(string)
  end

  def move_types
    [MoveTypes::KING_MOVEMENT, MoveTypes::CASTLING]
  end
end