# frozen_string_literal: true

class MoveValidator
  def initialize(board)
    @board = board
  end

  def valid_moves_from(pos)
    filter_illegal_moves(@board.piece_at(pos).moves)
  end

  private

  def filter_illegal_moves(moves_arr)
    moves_arr.reject do |move|
      moving_piece_color = @board.piece_at(move.from).color
      Evaluation.in_check_if?(@board, move, moving_piece_color)
    end
  end
end