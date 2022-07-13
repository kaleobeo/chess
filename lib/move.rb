# frozen_string_literal: true

class Move
  attr_reader :from, :to, :target

  def initialize(from, to, rules = [], target = nil)
    @from = from
    @to = to
    @rules = rules
    @target ||= to
  end

  # Movement types
  CARDINAL_MOVEMENT = lambda do |origin|
    destinations = [origin.horiz_line(8), origin.vert_line(8)].flatten - [origin]
    moves = destinations.map { |destination| Move.new(origin, destination, Rules::COLLISION, Rules::FRIENDLY_FIRE) }
    moves.filter { |move| move.to.is_a?(Position) }
  end
end