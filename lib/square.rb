# frozen_string_literal: true

class Square
  attr_reader :pos, :color
  attr_accessor :piece

  def initialize(color, pos)
    @pos = pos
    @piece = NullPiece.new
    @color = color
  end

  def piece_color
    piece&.color
  end

  def empty?
    piece.is_a?(NullPiece)
  end

  def clear_piece
    @piece = NullPiece.new
  end
end