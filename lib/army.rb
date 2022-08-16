# frozen_string_literal: true

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
    @pieces.each(&:clear_en_passant)
  end
end