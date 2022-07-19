# frozen_string_literal: true

require_relative '../lib/library'

describe Rook do
  describe '#represented_by?' do
    it 'is represented by r' do
      expect(described_class.represented_by?('r')).to eq true
    end

    it 'is represented by R' do
      expect(described_class.represented_by?('R')).to eq true
    end

    it 'is not represented by X' do
      expect(described_class.represented_by?('X')).to eq false
    end

    it 'is not represented by %' do
      expect(described_class.represented_by?('%')).to eq false
    end
  end

  describe '#moves' do
    context 'with 8/8/8/3R1R2/8/8/8/8 w - - 0 1 (empty board, rook on d5, ally rook on f5)' do
      let(:board) { Board.parse_fen('8/8/8/3R1R2/8/8/8/8 w - - 0 1') }
      let(:moves) { board.destinations_for(Position.parse('d5')) }

      it 'has 11 moves' do
        expect(moves.length).to eq 11
      end

      it 'can move to c5' do
        expect(moves).to include(Position.parse('c5'))
      end

      it 'can move to b5' do
        expect(moves).to include(Position.parse('b5'))
      end

      it 'can move to a5' do
        expect(moves).to include(Position.parse('a5'))
      end

      it 'can move to d6' do
        expect(moves).to include(Position.parse('d6'))
      end

      it 'can move to d7' do
        expect(moves).to include(Position.parse('d7'))
      end

      it 'can move to d8' do
        expect(moves).to include(Position.parse('d8'))
      end

      it 'can move to e5' do
        expect(moves).to include(Position.parse('e5'))
      end

      it 'can move to d4' do
        expect(moves).to include(Position.parse('d4'))
      end

      it 'can move to d3' do
        expect(moves).to include(Position.parse('d3'))
      end

      it 'can move to d2' do
        expect(moves).to include(Position.parse('d2'))
      end

      it 'can move to d1' do
        expect(moves).to include(Position.parse('d1'))
      end
    end

    context 'with 8/8/8/3R4/8/8/8/8 (empty board, rook on d5, enemy rook on e5)' do
      let(:board) { Board.parse_fen('8/8/8/3Rr3/8/8/8/8') }
      let(:moves) { board.destinations_for(Position.parse('d5')) }

      it 'has 11 moves' do
        expect(moves.length).to eq 11
      end

      it 'can move to c5' do
        expect(moves).to include(Position.parse('c5'))
      end

      it 'can move to b5' do
        expect(moves).to include(Position.parse('b5'))
      end

      it 'can move to a5' do
        expect(moves).to include(Position.parse('a5'))
      end

      it 'can move to e5' do
        expect(moves).to include(Position.parse('e5'))
      end

      it 'can move to d6' do
        expect(moves).to include(Position.parse('d6'))
      end

      it 'can move to d7' do
        expect(moves).to include(Position.parse('d7'))
      end

      it 'can move to d8' do
        expect(moves).to include(Position.parse('d8'))
      end

      it 'can move to d4' do
        expect(moves).to include(Position.parse('d4'))
      end

      it 'can move to d3' do
        expect(moves).to include(Position.parse('d3'))
      end

      it 'can move to d2' do
        expect(moves).to include(Position.parse('d2'))
      end

      it 'can move to d1' do
        expect(moves).to include(Position.parse('d1'))
      end
    end
  end
end