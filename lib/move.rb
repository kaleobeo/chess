# frozen_string_literal: true

class Move
  attr_reader :from, :to, :target, :rules

  def initialize(from, to, rules = [], target = nil)
    @from = from
    @to = to
    @rules = rules
    @target = target
    @target ||= to
  end

  def follows_rules?(board)
    @rules.all? { |rule| rule.call(self, board)}
  end

  def ==(other)
    other.class == self.class && from == other.from && to == other.to && target == other.target && rules == other.rules
  end

  # Movement types
  CARDINAL_MOVEMENT = lambda do |origin|
    destinations = [origin.horiz_line(8), origin.vert_line(8)].flatten - [origin]
    moves = destinations.map { |destination| Move.new(origin, destination, [Rules::COLLISION, Rules::FRIENDLY_FIRE]) }
    moves.filter { |move| move.to.is_a?(Position) }
  end

  DIAGONAL_MOVEMENT = lambda do |origin|
    destinations = [origin.diag_line_ne_sw(8), origin.diag_line_nw_se(8)].flatten - [origin]
    moves = destinations.map { |destination| Move.new(origin, destination, [Rules::COLLISION, Rules::FRIENDLY_FIRE]) }
    moves.filter { |move| move.to.is_a?(Position)}
  end

  KNIGHT_MOVEMENT = lambda do |origin|
    offsets = [2, -2, 1, -1].permutation(2).select { |arr| arr[0].abs != arr[1].abs}
    destinations = offsets.map { |pair| origin.up(pair[0]).right(pair[1]) }
    moves = destinations.map { |destination| Move.new(origin, destination, [Rules::FRIENDLY_FIRE]) }
    moves.filter { |move| move.to.is_a?(Position)}
  end

  KING_MOVEMENT = lambda do |origin|
    offsets = [1, -1, 0].repeated_permutation(2).to_a.delete_if { |pair| pair.all?(&:zero?) }
    destinations = offsets.map { |pair| origin.up(pair[0]).right(pair[1]) }
    moves = destinations.map { |destination| Move.new(origin, destination, [Rules::FRIENDLY_FIRE]) }
    moves.filter { |move| move.to.is_a?(Position) }
  end
end