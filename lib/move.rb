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
end