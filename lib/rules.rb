# frozen_string_literal: true

module Rules
  COLLISION = lambda do |move, board|
    move.from.line_to(move.to).all? { |pos| board.at(pos).empty? }
  end

  FRIENDLY_FIRE = lambda do |move, board|
    !board.piece_at(move.target).friendly_to?(board.at(move.from))
  end
end