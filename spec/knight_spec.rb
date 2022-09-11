# frozen_string_literal: true

require_relative '../lib/library'

describe Knight do
  describe '#represented_by?' do
    it 'is represented by n' do
      expect(described_class.represented_by?('n')).to be true
    end

    it 'is represented by N' do
      expect(described_class.represented_by?('n')).to be true
    end

    it 'is not represented by X' do
      expect(described_class.represented_by?('X')).to be false
    end

    it 'is not represented by %' do
      expect(described_class.represented_by?('%')).to be false
    end
  end

  describe '#moves' do
    context 'with 8/8/8/R1n5/8/1N6/8/8 w - - 0 1 (knight on b3, enemy knight c5)' do
      let(:board) { Board.parse_fen('8/8/8/R1n5/8/1N6/8/8 w - - 0 1') }
      let(:moves) { board.destinations_for(Position.parse('b3')) }

      it 'has 5 moves' do
        expect(moves.length).to eq 5
      end

      it 'can move to c5' do
        expect(moves).to include(Position.parse('c5'))
      end

      it 'can move to d4' do
        expect(moves).to include(Position.parse('d4'))
      end

      it 'can move to d2' do
        expect(moves).to include(Position.parse('d2'))
      end

      it 'can move to c1' do
        expect(moves).to include(Position.parse('c1'))
      end

      it 'can move to a1' do
        expect(moves).to include(Position.parse('a1'))
      end
    end
  end
end
