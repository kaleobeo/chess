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

  LINE_NOT_UNDER_ATTACK = lambda do |move, board|
    required_safe_squares = [move.from.line_to(move.to), move.to].flatten
    required_safe_squares.none? do |square|
      Evaluation.in_check_if?(board, Move.new(from: move.from, to: square), :white)
    end && !Evaluation.new(board).in_check?(board.piece_at(move.from).color)
  end

  CLEAR_PATH_BETWEEN = lambda do |start, finish|
    lambda do |_move, board|
      start.line_to(finish).all? { |square| board.at(square).empty? }
    end
  end

  NEIGHBOR_IS_ROOK_ON_START_POSITION = lambda do |pos|
    lambda do |_move, board|
      piece = board.piece_at(pos)
      (!piece.has_moved?) && piece.is_a?(Rook)
    end
  end
end