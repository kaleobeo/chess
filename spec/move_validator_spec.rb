# frozen_string_literal: true

require_relative '../lib/library'

describe MoveValidator do
  describe '#valid_moves_from' do
    context 'with 7K/8/8/8/R7/2pk4/8/8 w - - 0 1' do
      subject(:validator) { described_class.new(board) }
      
      let(:board) { Board.parse_fen('7K/8/8/8/R7/2pk4/8/8 w - - 0 1') }
      let(:moves) { validator.valid_moves_from(Position.parse('d3'))}

      it 'black king has 4 moves' do
        expect(moves.length).to eq 4
      end

      it 'can move to e3' do
        expect(moves.map(&:to)).to include Position.parse('e3')
      end

      it 'can move to e2' do
        expect(moves.map(&:to)).to include Position.parse('e2')
      end

      it 'can move to d2' do
        expect(moves.map(&:to)).to include Position.parse('d2')
      end

      it 'can move to c2' do
        expect(moves.map(&:to)).to include Position.parse('c2')
      end
    end

    context 'with 7K/8/8/8/8/R1pk4/8/8 w - - 0 1' do
      subject(:validator) { described_class.new(board) }

      let(:board) { Board.parse_fen('7K/8/8/8/8/R1pk4/8/8 w - - 0 1') }
      let(:pawn_moves) { validator.valid_moves_from(Position.parse('c3')) }

      it 'black pawn has 0 moves' do
        expect(pawn_moves.length).to eq 0
      end
    end

    context 'with R3r2k/8/8/8/8/5K2/8/8 w - - 0 1' do
      subject(:validator) { described_class.new(board) }

      let(:board) { Board.parse_fen('R3r2k/8/8/8/8/5K2/8/8 w - - 0 1') }
      let(:king_moves) { validator.valid_moves_from(Position.parse('f3')) }

      it 'has 5 moves' do
        expect(king_moves.length).to eq 5
      end

      it 'white king on f3' do
        expect(board.piece_at(Position.parse('f3')).is_a?(King)).to be true
      end
    end
  end
end