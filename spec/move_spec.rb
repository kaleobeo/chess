# frozen_string_literal: true

require_relative '../lib/library'

describe Move do
  describe '#follows_rules?' do
    context 'when one of a move\'s rules is broken by the board state' do
      subject(:illegal_move) do
        described_class.new(from: Position.parse('a1'), to: Position.parse('c1'),
                            rules: [Rules::COLLISION, Rules::FRIENDLY_FIRE])
      end

      it 'returns false' do
        expect(illegal_move.follows_rules?(Board.parse_fen('8/8/8/8/8/8/8/1R6 w - - 0 1'))).to be false
      end
    end

    context 'when none of a move\'s rules are broken by the board state' do
      subject(:legal_move) do
        described_class.new(from: Position.parse('a1'), to: Position.parse('c1'),
                            rules: [Rules::COLLISION, Rules::FRIENDLY_FIRE])
      end

      it 'returns true' do
        expect(legal_move.follows_rules?(Board.parse_fen('8/8/8/8/8/8/8/8 w - - 0 1'))).to be true
      end
    end
  end

  describe '#==' do
    subject(:move) do
      described_class.new(from: Position.parse('a1'), to: Position.parse('a3'), rules: [Rules::COLLISION])
    end

    context 'when objects share the same from, to, target, and rules attributes' do
      it 'returns true' do
        other = described_class.new(from: Position.parse('a1'), to: Position.parse('a3'), rules: [Rules::COLLISION])
        expect(move == other).to be true
      end
    end

    context 'when objects have one or more discrepancies between their from, to, target, and rules' do
      it 'returns false' do
        other = described_class.new(from: Position.parse('a1'), to: Position.parse('a4'),
                                    rules: [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(move == other).to be false
      end
    end
  end
end
