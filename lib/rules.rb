# frozen_string_literal: true

module Rules
  COLLISION = lambda do |move, board|
    move.from.line_to(move.to).all? { |pos| board.at(pos).empty? }
  end

  FRIENDLY_FIRE = lambda do |move, board|
    !board.piece_at(move.target).friendly_to?(board.piece_at(move.from))
  end

  EMPTY_DESTINATION = lambda do |move, board|
    board.at(move.to).empty?
  end

  OCCUPIED_TARGET = lambda do |move, board|
    !board.at(move.target).empty?
  end

  ON_START_POSITION = lambda do |move, board|
    !board.piece_at(move.from).has_moved?
  end

  EN_PASSANT = lambda do |move, board|
    board.piece_at(move.target).can_en_passant?
  end
end