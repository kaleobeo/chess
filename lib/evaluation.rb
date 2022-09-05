# frozen_string_literal: true

class Evaluation
  def initialize(board)
    @board = board
    @teams = board.teams
  end

  def conclusion(color)
    if in_checkmate?(color)
      'checkmate'
    elsif in_stalemate?(color)
      'stalemate'
    elsif fifty_move_clock_exceeded?
      'fifty move rule'
    end
  end

  def in_check?(color)
    unfriendly_moves(color).include?(@teams[color].king.pos)
  end

  def fifty_move_clock_exceeded?
    @board.half_move_clock > 100
  end

  def in_checkmate?(color)
    in_check?(color) && MoveValidator.new(@board).no_legal_moves?(color)
  end

  def in_stalemate?(color)
    !in_check?(color) && MoveValidator.new(@board).no_legal_moves?(color)
  end

  def self.in_check_if?(board, move, color)
    clone = Marshal.load(Marshal.dump(board))
    clone.move(move)
    Evaluation.new(clone).in_check?(color)
  end

  def find_promotable_pawn(color)
    @board.teams[color].promotable_pawn
  end

  private

  def unfriendly_moves(color)
    @board.teams.reject { |team_color, team| color == team_color }.values.map(&:capture_moves).flatten.map(&:target)
  end
end