# frozen_string_literal: true

class Piece
  attr_reader :color, :pos

  def self.parse(string, pos)
    @registry ||= [Piece]
    @registry.find { |piece| piece.represented_by?(string) }.new(string, pos)
  end

  def self.inherited(subclass)
    super(subclass)
    @registry ||= [Piece]
    @registry.unshift(subclass)
  end

  def self.represented_by?(_string)
    true
  end

  def initialize(*_args)
    raise 'Piece should not be initialized'
  end

  def friendly_to?(attacker)
    attacker.color == @color
  end

  def moves
    move_types.map { |type| type.call(@pos) }.flatten
  end

  def ==(other)
    self.class == other.class && color == other.color && pos == other.pos
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