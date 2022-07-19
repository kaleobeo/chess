# frozen_string_literal: true

require_relative '../lib/library'

describe Bishop do
  describe '#represented_by?' do
    it 'is represented by b' do
      expect(described_class.represented_by?('b')).to eq true
    end

    it 'is represented by B' do
      expect(described_class.represented_by?('B')).to eq true
    end

    it 'is not represented by X' do
      expect(described_class.represented_by?('X')).to eq false
    end

    it 'is not represented by %' do
      expect(described_class.represented_by?('%')).to eq false
    end
  end
  describe '#moves' do
    context 'with 8/8/5R2/8/3B4/8/8/8 w - - 0 1 (board empty, white bishop d4)' do
      let(:board) { Board.parse_fen('8/8/5R2/8/3B4/8/8/8 w - - 0 1') }
      let(:moves) { board.piece_at(Position.parse('d4')).moves }

      it 'has 10 moves' do
        expect(moves.length).to eq 10
      end

      it 'can move to c3' do
        move = Move.new(Position.parse('d4'), Position.parse('c3'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to b2' do
        move = Move.new(Position.parse('d4'), Position.parse('b2'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to a1' do
        move = Move.new(Position.parse('d4'), Position.parse('a1'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to c5' do
        move = Move.new(Position.parse('d4'), Position.parse('c5'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to b6' do
        move = Move.new(Position.parse('d4'), Position.parse('b6'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to a7' do
        move = Move.new(Position.parse('d4'), Position.parse('a7'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to e5' do
        move = Move.new(Position.parse('d4'), Position.parse('e5'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to e3' do
        move = Move.new(Position.parse('d4'), Position.parse('e3'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to f2' do
        move = Move.new(Position.parse('d4'), Position.parse('f2'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to g1' do
        move = Move.new(Position.parse('d4'), Position.parse('g1'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end
    end

    context 'with \'8/8/8/4b3/3B4/8/8/8 w - - 0 1\'' do
      let(:board) { Board.parse_fen('8/8/8/4b3/3B4/8/8/8 w - - 0 1') }
      let(:moves) { board.piece_at(Position.parse('d4')).moves }

      it 'has 10 moves' do
        expect(moves.length).to eq 10
      end

      it 'can move to c3' do
        move = Move.new(Position.parse('d4'), Position.parse('c3'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to b2' do
        move = Move.new(Position.parse('d4'), Position.parse('b2'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to a1' do
        move = Move.new(Position.parse('d4'), Position.parse('a1'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to c5' do
        move = Move.new(Position.parse('d4'), Position.parse('c5'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to b6' do
        move = Move.new(Position.parse('d4'), Position.parse('b6'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to a7' do
        move = Move.new(Position.parse('d4'), Position.parse('a7'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to e5' do
        move = Move.new(Position.parse('d4'), Position.parse('e5'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to e3' do
        move = Move.new(Position.parse('d4'), Position.parse('e3'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to f2' do
        move = Move.new(Position.parse('d4'), Position.parse('f2'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to g1' do
        move = Move.new(Position.parse('d4'), Position.parse('g1'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end
    end
  end
end