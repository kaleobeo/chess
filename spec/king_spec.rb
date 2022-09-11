# frozen_string_literal: true

require_relative '../lib/library'

describe King do
  describe '#self.represented_by?' do
    it 'is represented by k' do
      expect(described_class.represented_by?('k')).to be true
    end

    it 'is represented by K' do
      expect(described_class.represented_by?('K')).to be true
    end

    it 'is not represented by an invalid letter' do
      expect(described_class.represented_by?('X')).to be false
    end

    it 'is not represented by a symbol' do
      expect(described_class.represented_by?('%')).to be false
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

    context 'castling' do
      context 'with 8/8/8/8/8/8/8/R3K2R w KQ - 0 1' do
        let(:board) { Board.parse_fen('8/8/8/8/8/8/8/R3K2R w KQ - 0 1') }
        let(:moves) { board.destinations_for(Position.parse('e1')) }

        it 'can move to g1' do
          expect(moves).to include Position.parse('g1')
        end

        it 'can move to c1' do
          expect(moves).to include Position.parse('c1')
        end

        context 'after O-O' do
          before do
            castle = board.piece_at(Position.parse('e1')).moves.find { |move| move.to == Position.parse('g1') }
            board.move(castle)
          end

          it 'lands on g1' do
            expect(board.piece_at(Position.parse('g1'))).to be board.teams[:white].king
          end

          it 'white queenside rook moves to f1' do
            f1_piece = board.piece_at(Position.parse('f1'))
            expect(f1_piece.is_a?(Rook) && f1_piece.color == :white).to be true
          end
        end
      end

      context 'with 6r1/8/8/8/8/8/8/R3K2R w - - 0 1' do
        let(:board) { Board.parse_fen('6r1/8/8/8/8/8/8/R3K2R w - - 0 1') }
        let(:moves) { board.destinations_for(Position.parse('e1')) }

        it 'cannot castle kingside' do
          expect(moves).not_to include(Position.parse('g1'))
        end

        it 'can castle queenside' do
          expect(moves).to include(Position.parse('c1'))
        end

        context 'after O-O-O' do
          before do
            castle = board.piece_at(Position.parse('e1')).moves.find { |move| move.to == Position.parse('c1') }
            board.move(castle)
          end

          it 'lands on c1' do
            expect(board.piece_at(Position.parse('c1'))).to be board.teams[:white].king
          end

          it 'white queenside rook moves to d1' do
            d1_piece = board.piece_at(Position.parse('d1'))
            expect(d1_piece.is_a?(Rook) && d1_piece.color == :white).to be true
          end
        end
      end
    end
  end
end
