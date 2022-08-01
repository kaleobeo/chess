# frozen_string_literal: true

class Bishop < Piece

  def self.represented_by?(string)
    %w[b B].include?(string)
  end

  private

  def move_types
    [MoveTypes::DIAGONAL_MOVEMENT]
  end
end