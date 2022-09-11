# frozen_string_literal: true

# Army class acts as a storage for all of the pieces in a player's
# possession, it is made to hide the actual pieces from collaborators
class Army
  def initialize
    @pieces = []
  end

  def add_piece(piece)
    @pieces.push(piece)
  end

  def piece_captured(piece)
    @pieces.delete(piece)
  end

  def king
    @pieces.find { |piece| piece.is_a?(King) }
  end

  def moves
    @pieces.map(&:moves).flatten
  end

  def capture_moves
    @pieces.map(&:capture_moves).flatten
  end

  def target_squares
    moves.map(&:target)
  end

  def clear_en_passant
    @pieces.each(&:remove_en_passant)
  end

  def en_passant_square
    @pieces.find(&:can_en_passant?)&.skipped_square
  end

  def promotable_pawn
    @pieces.find { |piece| piece.is_a?(Pawn) && piece.on_promotion_rank? }
  end

  def pieces_fen_rep
    @pieces.map(&:fen_char).sort.join
  end

  def bishop_square_color
    @pieces.find { |piece| piece.is_a?(Bishop) }.square_color
  end
end