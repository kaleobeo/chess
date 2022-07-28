# frozen_string_literal: true

class Move
  attr_reader :from, :to, :target, :rules, :displacements

  def initialize(from:, to:, rules: [], target: nil, displacements: [])
    @from = from
    @to = to
    @rules = rules
    @target = target
    @target ||= to
    @displacements = displacements
  end

  def follows_rules?(board)
    @rules.all? { |rule| rule.call(self, board)}
  end

  def ==(other)
    other.class == self.class && from == other.from && to == other.to && target == other.target && rules == other.rules
  end

  def open_to_en_passant?(board)
    rules.include?(Rules::ON_START_POSITION) && board.piece_at(from).is_a?(Pawn)
  end

  # Movement types
  CARDINAL_MOVEMENT = lambda do |origin|
    destinations = [origin.horiz_line(8), origin.vert_line(8)].flatten - [origin]
    moves = destinations.map { |destination| Move.new(from: origin, to: destination, rules: [Rules::COLLISION, Rules::FRIENDLY_FIRE]) }
    moves.filter { |move| move.to.is_a?(Position) }
  end

  DIAGONAL_MOVEMENT = lambda do |origin|
    destinations = [origin.diag_line_ne_sw(8), origin.diag_line_nw_se(8)].flatten - [origin]
    moves = destinations.map { |destination| Move.new(from: origin, to: destination, rules: [Rules::COLLISION, Rules::FRIENDLY_FIRE]) }
    moves.filter { |move| move.to.is_a?(Position) }
  end

  KNIGHT_MOVEMENT = lambda do |origin|
    offsets = [2, -2, 1, -1].permutation(2).reject { |arr| arr[0].abs == arr[1].abs }
    destinations = offsets.map { |pair| origin.up(pair[0]).right(pair[1]) }
    moves = destinations.map { |destination| Move.new(from: origin, to: destination, rules: [Rules::FRIENDLY_FIRE]) }
    moves.filter { |move| move.to.is_a?(Position) }
  end

  KING_MOVEMENT = lambda do |origin|
    offsets = [1, -1, 0].repeated_permutation(2).to_a.delete_if { |pair| pair.all?(&:zero?) }
    destinations = offsets.map { |pair| origin.up(pair[0]).right(pair[1]) }
    moves = destinations.map { |destination| Move.new(from: origin, to: destination, rules: [Rules::FRIENDLY_FIRE]) }
    moves.filter { |move| move.to.is_a?(Position) }
  end

  FORWARD_MOVEMENT = lambda do |origin, direction|
    [Move.new(from: origin, to: origin.up(direction), rules: [Rules::EMPTY_DESTINATION])]
  end

  DOUBLE_FIRST_MOVEMENT = lambda do |origin, direction|
    [Move.new(from: origin, to: origin.up(2 * direction), rules:[Rules::EMPTY_DESTINATION, Rules::ON_START_POSITION, Rules::COLLISION])]
  end

  DIAGONAL_CAPTURE = lambda do |origin, direction|
    offsets = [1, -1]
    targets = offsets.map { |offset| origin.up(direction).right(offset) }
    moves = targets.map { |target| Move.new(from: origin, to: target, rules: [Rules::FRIENDLY_FIRE, Rules::OCCUPIED_TARGET]) }
    moves.filter { |move| move.to.is_a?(Position) }
  end

  EN_PASSANT = lambda do |origin, direction|
    offsets = [1, -1]
    moves = offsets.map do |offset|
      destination = origin.up(direction).right(offset)
      rules = [Rules::FRIENDLY_FIRE, Rules::OCCUPIED_TARGET, Rules::EN_PASSANT, Rules::EMPTY_DESTINATION]
      Move.new(from: origin, to: destination, rules:, target: destination.down(direction))
    end
    moves.filter { |move| move.to.is_a?(Position) }
  end

  CASTLING = lambda do |origin|
    directions = [2, -2]
    moves = directions.map do |distance|
      rook_pos = origin.right(distance.negative? ? -4 : 3)
      destination = origin.right(distance)
      rules = [Rules::LINE_NOT_UNDER_ATTACK, Rules::CLEAR_PATH_BETWEEN.call(origin, rook_pos)]
      rook_end_pos = destination.right(distance.negative? ? 1 : -1)
      Move.new(from: origin, to: destination, rules:, displacements: [{ from: rook_pos, to: rook_end_pos }])
    end
    moves.filter { |move| move.to.is_a?(Position) }
  end
end