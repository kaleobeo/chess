# frozen_string_literal: true

require_relative '../lib/library'

describe King do
  describe '#self.represented_by?' do
    it 'is represented by k' do
      expect(described_class.represented_by?('k')).to eq true
    end

    it 'is represented by K' do
      expect(described_class.represented_by?('K')).to eq true
    end

    it 'is not represented by an invalid letter' do
      expect(described_class.represented_by?('X')).to eq false
    end

    it 'is not represented by a symbol' do
      expect(described_class.represented_by?('%')).to eq false
    end
  end

  describe '#moves' do
    context 'with 8/8/8/8/8/2b5/1KQ5/8 w - - 0 1 (white king b2 white queen c2 black bishop c3)' do
      let(:board) { Board.parse_fen('8/8/8/8/8/2b5/1KQ5/8 w - - 0 1') }
      let(:moves) { board.destinations_for(Position.parse('b2')) }

      it 'has 7 moves' do
        expect(moves.length).to eq 7
      end

      it 'can move to a1' do
        expect(moves).to include(Position.parse('a1'))
      end

      it 'can move to a2' do
        expect(moves).to include(Position.parse('a2'))
      end

      it 'can move to a3' do
        expect(moves).to include(Position.parse('a3'))
      end

      it 'can move to b3' do
        expect(moves).to include(Position.parse('b3'))
      end

      it 'can move to c3' do
        expect(moves).to include(Position.parse('c3'))
      end

      it 'can move to c1' do
        expect(moves).to include(Position.parse('c1'))
      end
    end
  end
end