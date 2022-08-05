# frozen_string_literal: true

class Square
  attr_reader :pos, :color
  attr_accessor :piece

  def to_s
    if empty? && @highlighted
      "\u001b[48;5;172m \u2022 "
    else
      case color
      when :light
        "\u001b[48;5;#{!empty? && @highlighted ? 172 : 249}m#{piece}"
      when :dark
        "\u001b[48;5;#{!empty? && @highlighted ? 172 : 30}m#{piece}"
      end
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

  def highlight
    @highlighted = true
  end

  def remove_highlight
    @highlighted = false
  end
end