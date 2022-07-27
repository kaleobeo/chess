# frozen_string_literal: true

require_relative '../lib/library'

describe Pawn do
  describe '#self.represented_by?' do
    it 'is represented by p' do
      expect(described_class.represented_by?('p')).to be true
    end

    it 'is represented by P' do
      expect(described_class.represented_by?('P')).to be true
    end

    it 'is not represented by X' do
      expect(described_class.represented_by?('X')).to be false
    end

    it 'is not represented by %' do
      expect(described_class.represented_by?('%')).to be false
    end
  end

  describe '#can_en_passant?' do
    context 'with 8/8/8/8/3P4/8/8/8 w - - 0 1 (last move was double move)' do
      let(:board) { Board.parse_fen('8/8/8/8/8/8/3P4/8 w - - 0 1') }

      before do
        board.move(Move.new(from: Position.parse('d2'), to: Position.parse('d4'), rules: [Rules::ON_START_POSITION]))
      end

      it 'is open to en passant' do
        expect(board.piece_at(Position.parse('d4')).can_en_passant?).to be true
      end
    end

    context 'with 8/8/8/8/3P4/8/8/8 w - - 0 1 (last move was not double move)' do
      let(:board) { Board.parse_fen('8/8/8/8/3P4/8/8/8 w - - 0 1') }

      before do
        board.move(Move.new(from: Position.parse('d2'), to: Position.parse('d3')))
      end

      it 'is not open to en passant' do
        expect(board.piece_at(Position.parse('d3')).can_en_passant?).to be false
      end
    end
  end

  describe '#moves' do
    context 'forward movement' do
      context 'with 8/8/8/8/8/8/1P6/8 w - - 0 1' do
        let(:board) { Board.parse_fen('8/8/8/8/8/8/1P6/8 w - - 0 1') }
        let(:moves) { board.destinations_for(Position.parse('b2')) }

        it 'has two moves' do
          expect(moves.length).to eq 2
        end

        it 'can move to b3' do
          expect(moves).to include Position.parse('b3')
        end

        it 'can move to b4' do
          expect(moves).to include Position.parse('b4')
        end
      end

      context 'with 8/8/8/8/8/1P6/1P6/8 w - - 0 1' do
        let(:board) { Board.parse_fen('8/8/8/8/8/1P6/1P6/8 w - - 0 1') }
        let(:moves) { board.destinations_for(Position.parse('b2')) }

        it 'has no moves' do
          expect(moves.length).to eq 0
        end
      end

      context 'with 8/8/8/8/8/1P6/8/8 w - - 0 1 (white has just moved 1..b3)' do
        let(:board) { Board.parse_fen('8/8/8/8/8/8/1P6/8 w - - 0 1') }
        let(:moves) { board.destinations_for(Position.parse('b3')) }

        before do
          board.move(Move.new(from: Position.parse('b2'), to: Position.parse('b3')))
        end

        it 'has one move' do
          expect(moves.length).to eq 1
        end

        it 'can move to b4' do
          expect(moves).to include Position.parse('b4')
        end
      end

      context 'with 8/6p1/8/8/8/8/8/8 w - - 0 1' do
        let(:board) { Board.parse_fen('8/6p1/8/8/8/8/8/8 w - - 0 1') }
        let(:moves) { board.destinations_for(Position.parse('g7')) }

        it 'has two moves' do
          expect(moves.length).to eq 2
        end

        it 'can move to g6' do
          expect(moves).to include Position.parse('g6')
        end

        it 'can move to g5' do
          expect(moves).to include Position.parse('g5')
        end
      end

      context 'with 8/6p1/6p1/8/8/8/8/8 w - - 0 1' do
        let(:board) { Board.parse_fen('8/6p1/6p1/8/8/8/8/8 w - - 0 1') }
        let(:moves) { board.destinations_for(Position.parse('g7')) }

        it 'has no moves' do
          expect(moves.length).to eq 0
        end
      end

      context 'with 8/8/6p1/8/8/8/8/8 w - - 0 1 (black has just moved 1..g6)' do
        let(:board) { Board.parse_fen('8/6p1/8/8/8/8/8/8 w - - 0 1') }
        let(:moves) { board.destinations_for(Position.parse('g6')) }

        before do
          board.move(Move.new(from: Position.parse('g7'), to: Position.parse('g6')))
        end

        it 'has one move' do
          expect(moves.length).to eq 1
        end

        it 'can move to g5' do
          expect(moves).to include Position.parse('g5')
        end
      end
    end

    context 'diagonal capture' do
      context 'with 8/8/8/4p3/3P4/8/8/8 w - - 0 1 (white to move)' do
        let(:board) { Board.parse_fen('8/8/8/4p3/3P4/8/8/8 w - - 0 1') }
        let(:moves) { board.destinations_for(Position.parse('d4')) }

        before do
          board.piece_at(Position.parse('d4')).instance_variable_set(:@has_moved, true)
        end

        it 'has two moves' do
          expect(moves.length).to eq 2
        end

        it 'can move to d5' do
          expect(moves).to include Position.parse('d5')
        end

        it 'can move to e5' do
          expect(moves).to include Position.parse('e5')
        end
      end

      context 'with 8/8/8/4p3/3P4/8/8/8 b - - 0 1 (black to move)' do
        let(:board) { Board.parse_fen('8/8/8/4p3/3P4/8/8/8 b - - 0 1') }
        let(:moves) { board.destinations_for(Position.parse('e5')) }

        before do
          board.piece_at(Position.parse('e5')).instance_variable_set(:@has_moved, true)
        end

        it 'has two moves' do
          expect(moves.length).to eq 2
        end

        it 'can move to d4' do
          expect(moves).to include Position.parse('d4')
        end

        it 'can move to e4' do
          expect(moves).to include Position.parse('e4')
        end
      end
    end

    context 'en passant' do
      context 'with 8/8/8/3Pp3/8/8/8/8 w - - 0 1 (black pawn is vulnerable to en passant)' do
        let(:board) { Board.parse_fen('8/8/8/3Pp3/8/8/8/8 w - - 0 1') }
        let(:moves) { board.destinations_for(Position.parse('d5')) }

        before do
          allow(board.piece_at(Position.parse('e5'))).to receive(:can_en_passant?).and_return true
          board.piece_at(Position.parse('d5')).instance_variable_set(:@has_moved, true)
        end

        it 'can move to e6' do
          expect(moves).to include Position.parse('e6')
        end

        context 'when dxe5' do
          let(:white_pawn) { board.piece_at(Position.parse('d5')) }

          before do
            board.move(white_pawn.moves[1])
          end

          it 'white pawn lands on e6' do
            expect(white_pawn.pos).to eq Position.parse('e6')
          end

          it 'e5 is empty' do
            expect(board.at(Position.parse('e5'))).to be_empty
          end
        end
      end

      context 'with 8/8/8/3Pp3/8/8/8/8 w - - 0 1 (black pawn is not vulnerable to en passant)' do
        let(:board) { Board.parse_fen('8/8/8/3Pp3/8/8/8/8 w - - 0 1') }
        let(:moves) { board.piece_at(Position.parse('d5')).moves }

        before do
          board.piece_at(Position.parse('d5')).instance_variable_set(:@has_moved, true)
        end

        it 'has one move' do
          expect(moves.length).to eq 1
        end
      end
    end
  end
end
