# frozen_string_literal: true

class Knight < Piece
  def self.represented_by?(string)
    %w[n N].include?(string)
  end

  private

  def move_types
    [Move::KNIGHT_MOVEMENT]
  end
end