# frozen_string_literal: true

class Square
  attr_reader :pos, :color
  attr_accessor :piece

  def initialize(color, pos)
    @pos = pos
    @piece = nil
    @color = color
  end

  def piece_color
    piece&.color
  end

  def empty?
    piece.nil?
  end

  def clear_piece
    @piece = nil
  end
end