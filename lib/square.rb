# frozen_string_literal: true

# Squares store their color, and a piece, as well as having some additional logic for how to display the square and its pieces in different situations.
class Square
  attr_reader :pos, :color
  attr_accessor :piece

  def to_s
    if @highlighted
      if empty?
        "\u001b[48;5;#{ascii_num}m\u001b[38;5;237m \u2022 \u001b[0m"
      else
        "\u001b[48;5;208m#{piece}\u001b[0m"
      end

    else
      "\u001b[48;5;#{ascii_num}m#{piece}\u001b[0m"
    end
  end

  def ascii_num
    case color
    when :light
      249
    when :dark
      30
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
