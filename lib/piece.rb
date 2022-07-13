# frozen_string_literal: true

class Piece
  def self.parse(string, pos)
    @registry ||= [Piece]
    @registry.find { |piece| piece.represented_by?(string) }.new(string, pos)
  end

  def self.inherited(subclass)
    super(subclass)
    @registry ||= []
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

  private

  def white_piece?(string)
    string.upcase == string
  end

  def black_piece?(string)
    string.downcase == string
  end

  def set_color
    @color = if white_piece?(string)
               :white
             elsif black_piece?(string)
               :black
             end
  end
end