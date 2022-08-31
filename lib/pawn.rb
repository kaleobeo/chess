# frozen_string_literal: true

class Pawn < Piece
  attr_reader :can_en_passant
  alias :can_en_passant? :can_en_passant

  def symbol
    "\u265F"
  end

  def fen_char
    color == :white ? 'P' : 'p'
  end

  def self.represented_by?(string)
    %w[p P].include?(string)
  end

  def moves
    move_types.map { |type| type.call(@pos, movement_direction) }.flatten.filter { |move| move.follows_rules?(@board) }
  end

  def capture_moves
    move_types.reject { |type| type == MoveTypes::CASTLING }.map { |type| type.call(@pos, movement_direction) }.flatten.filter { |move| move.follows_rules?(@board) }
  end

  def initialize(string, pos, board)
    super(string, pos, board)
    @can_en_passant = false
    @has_moved = true unless on_home_rank?
  end

  def moved(move)
    super(move)
    @can_en_passant = move.open_to_en_passant?(board)
  end

  def remove_en_passant
    @can_en_passant = false
  end

  def skipped_square
    can_en_passant? ? pos.down(movement_direction) : nil
  end

  def on_promotion_rank?
    pos.row == promotion_rank
  end

  def on_home_rank?
    pos.row == home_rank
  end

  private

  def move_types
    [MoveTypes::FORWARD_MOVEMENT, MoveTypes::DOUBLE_FIRST_MOVEMENT, MoveTypes::DIAGONAL_CAPTURE, MoveTypes::EN_PASSANT]
  end

  def movement_direction
    { white: 1, black: -1 }[color]
  end

  def promotion_rank
    { white: 8, black: 1 }[color]
  end

  def home_rank
    { white: 2, black: 7 }[color]
  end
end