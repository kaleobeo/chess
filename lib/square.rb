# frozen_string_literal: true

class Square
  attr_reader :pos, :color
  attr_accessor :piece

  def to_s
    case color
    when :light
      "\u001b[48;5;249m#{piece}"
    when :dark
      "\u001b[48;5;30m#{piece}"
    end
  end

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