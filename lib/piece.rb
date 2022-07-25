# frozen_string_literal: true

class Piece
  attr_reader :color, :board, :has_moved
  attr_accessor :pos
  alias :has_moved? :has_moved

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

  def friendly_to?(attacker)
    attacker.color == @color
  end

  def moves
    move_types.map { |type| type.call(@pos) }.flatten.filter { |move| move.follows_rules?(@board) }
  end

  def moved(move)
    @pos = move.to
    @has_moved = true
  end

  def ==(other)
    self.class == other.class && color == other.color && pos == other.pos && board == other.board
  end

  def can_en_passant?
    false
  end

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