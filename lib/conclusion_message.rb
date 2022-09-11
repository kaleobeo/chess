# frozen_string_literal: true

# Object that holds info about a game to construct the final message
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
      "Draw by #{@type}"
    end
  end
end
