# frozen_string_literal: true

# Detects check, checkmate, stalemate, and other draws by interacting with Board, Armies, and moves. Using a deep copy,
# is able to look at a move and detect whether it will result in a check.
class Evaluation
  INSUFF_MATERIAL_STATES = [
    %w[k K],
    %w[kn K],
    %w[k KN],
    %w[kn KN],
    %w[kb K],
    %w[k KB],
    %w[kb KB]
  ].map { |state| state.map! { |team_list| team_list.chars.sort.join }.sort }

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
    elsif insufficient_material?
      'insufficient material'
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

  def insufficient_material?
    return same_color_bishops? if sorted_remaining_pieces == %w[BK bk]

    INSUFF_MATERIAL_STATES.include?(sorted_remaining_pieces)
  end

  private

  def same_color_bishops?
    @teams.values.all? { |team| team.bishop_square_color == @teams.values.first.bishop_square_color }
  end

  def unfriendly_moves(color)
    @board.teams.reject { |team_color, _team| color == team_color }.values.map(&:capture_moves).flatten.map(&:target)
  end

  def sorted_remaining_pieces
    @teams.values.map(&:pieces_fen_rep).sort
  end
end
