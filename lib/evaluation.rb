# frozen_string_literal: true

class Evaluation
  def initialize(board)
    @board = board
    @teams = board.teams
  end

  def in_check?(color)
    unfriendly_moves(color).include?(@teams[color].king.pos)
  end

  def self.in_check_if?(board, move, color)
    board = Marshal.load(Marshal.dump(board))
    board.move(move)
    Evaluation.new(board).in_check?(color)
  end

  private

  def unfriendly_moves(color)
    @board.teams.reject { |team_color, team| color == team_color }.values.map(&:capture_moves).flatten.map(&:target)
  end
end