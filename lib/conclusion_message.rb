# frozen_string_literal: true

class ConclusionMessage
  def initialize(type, prev_player)
    @prev_player = prev_player
    @type = type
  end

  def message
    case @type
    when :checkmate
      "#{@prev_player.name} wins by CHECKMATE"
    else
      "Draw by #{type}"
    end
  end
end