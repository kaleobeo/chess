# frozen_string_literal: true

class MoveValidator
  def initialize(board)
    @board = board
  end

  def valid_moves_from(pos)
    filter_illegal_moves(@board.piece_at(pos).moves)
  end

  def valid_moves(piece)
    filter_illegal_moves(piece.moves)
  end

  def king_can_move?(color)
    !valid_moves(@board.teams[color].king).empty?
  end

  def no_legal_moves?(color)
    filter_illegal_moves(@board.teams[color].moves).empty?
  end

  def all_legal_moves(color)
    filter_illegal_moves(@board.teams[color].moves)
  end

  private

  def filter_illegal_moves(moves_arr)
    moves_arr.reject do |move|
      moving_piece_color = @board.piece_at(move.from).color
      Evaluation.in_check_if?(@board, move, moving_piece_color)
    end
  end
end