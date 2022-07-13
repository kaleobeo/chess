# frozen_string_literal: true

class Rook < Piece
  def initialize(string, pos)
    set_color(string)
    @pos = pos
  end

  def self.represented_by?(string)
    %w[r R].include?(string)
  end

  private

  def move_types
    [Move::CARDINAL_MOVEMENT]
  end
end