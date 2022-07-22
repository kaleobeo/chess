# frozen_string_literal: true

require_relative '../lib/library'

describe Queen do
  describe '#represented_by?' do
    it 'is represented by q' do
      expect(described_class.represented_by?('q')).to eq true
    end

    it 'is represented by Q' do
      expect(described_class.represented_by?('Q')).to eq true
    end

    it 'is not represented by X' do
      expect(described_class.represented_by?('X')).to eq false
    end

    it 'is not represented by %' do
      expect(described_class.represented_by?('%')).to eq false
    end
  end

  describe '#moves' do
    context 'with 8/8/8/4r3/8/2Q2B2/8/8 w - - 0 1 (queen c3, ally bishop f3, enemy rook e5)' do
      let(:board) { Board.parse_fen('8/8/8/4r3/8/2Q2B2/8/8 w - - 0 1') }
      let(:moves) { board.destinations_for(Position.parse('c3')) }

      it 'has 19 moves' do
        expect(moves.length).to eq 19
      end

      it 'can move to b2' do
        expect(moves).to include(Position.parse('b2'))
      end

      it 'can move to a1' do
        expect(moves).to include(Position.parse('a1'))
      end

      it 'can move to b3' do
        expect(moves).to include(Position.parse('b3'))
      end

      it 'can move to a3' do
        expect(moves).to include(Position.parse('a3'))
      end

      it 'can move to b4' do
        expect(moves).to include(Position.parse('b4'))
      end

      it 'can move to a5' do
        expect(moves).to include(Position.parse('a5'))
      end

      it 'can move to c4' do
        expect(moves).to include(Position.parse('c4'))
      end

      it 'can move to c5' do
        expect(moves).to include(Position.parse('c5'))
      end

      it 'can move to c6' do
        expect(moves).to include(Position.parse('c6'))
      end

      it 'can move to c7' do
        expect(moves).to include(Position.parse('c7'))
      end

      it 'can move to c8' do
        expect(moves).to include(Position.parse('c8'))
      end

      it 'can move to d4' do
        expect(moves).to include(Position.parse('d4'))
      end

      it 'can move to e5' do
        expect(moves).to include(Position.parse('e5'))
      end

      it 'can move to d3' do
        expect(moves).to include(Position.parse('d3'))
      end

      it 'can move to d4' do
        expect(moves).to include(Position.parse('d4'))
      end

      it 'can move to d2' do
        expect(moves).to include(Position.parse('d2'))
      end

      it 'can move to e1' do
        expect(moves).to include(Position.parse('e1'))
      end
    end
  end
end