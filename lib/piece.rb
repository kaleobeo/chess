# frozen_string_literal: true

# A parent abstract class for all types of pieces. Pieces use their move_types list (defined in the child class) to find
# their moves, yielding their position to it. Then, it filters the list of moves by again yielding their associated board to a Rule lambda.
class Piece
  attr_reader :color, :board, :has_moved, :pos
  alias has_moved? has_moved

  def to_s
    case color
    when :white
      "\u001b[38;5;230m #{symbol} "
    when :black
      "\u001b[38;5;233m #{symbol} "
    end + "\u001b[0m"
  end

  def self.parse(string, pos, board)
    @registry ||= [NullPiece]
    @registry.find { |piece| piece.represented_by?(string) }.new(string, pos, board)
  end

  def self.inherited(subclass)
    super(subclass)
    @registry ||= [NullPiece]
    @registry.unshift(subclass)
  end

  def self.represented_by?(_string)
    raise NotImplementedError, "#{self.class} does not implement method \"#{__method__}\""
  end

  def initialize(string, pos, board)
    set_color(string)
    @pos = pos
    @board = board
    @has_moved = false
  end

  def square_color
    @board.at(pos).color
  end

  def friendly_to?(attacker)
    attacker.color == @color
  end

  def moves
    move_types.map { |type| type.call(@pos) }.flatten.filter { |move| move.follows_rules?(@board) }
  end

  def capture_moves
    move_types.reject do |type|
      type == MoveTypes::CASTLING
    end.map { |type| type.call(@pos) }.flatten.filter { |move| move.follows_rules?(@board) }
  end

  def moved(move)
    @pos = move.is_a?(Move) ? move.to : move[:to]
    @has_moved = true
  end

  def ==(other)
    self.class == other.class && color == other.color && pos == other.pos && board == other.board
  end

  def can_en_passant?
    false
  end

  def remove_en_passant; end

  private

  def white_piece?(string)
    string.upcase == string
  end

  def black_piece?(string)
    string.downcase == string
  end

  def set_color(string)
    @color = if white_piece?(string)
               :white
             elsif black_piece?(string)
               :black
             end
  end

  def move_types
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
