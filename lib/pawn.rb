# frozen_string_literal: true

class Pawn < Piece
  attr_reader :can_en_passant
  alias :can_en_passant? :can_en_passant

  def self.represented_by?(string)
    %w[p P].include?(string)
  end

  def moves
    move_types.map { |type| type.call(@pos, movement_direction) }.flatten.filter { |move| move.follows_rules?(@board) }
  end

  def capture_moves
    move_types.reject { |type| type == Move::CASTLING }.map { |type| type.call(@pos, movement_direction) }.flatten.filter { |move| move.follows_rules?(@board) }
  end

  def initialize(string, pos, board)
    super(string, pos, board)
    @can_en_passant = false
  end

  def moved(move)
    super(move)
    @can_en_passant = move.open_to_en_passant?(board)
  end

  private

  def move_types
    [MoveTypes::FORWARD_MOVEMENT, MoveTypes::DOUBLE_FIRST_MOVEMENT, MoveTypes::DIAGONAL_CAPTURE, MoveTypes::EN_PASSANT]
  end

  def movement_direction
    { white: 1, black: -1 }[color]
  end
end