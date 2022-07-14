# frozen_string_literal: true

require_relative '../lib/library'

describe Board do
  describe '#place_piece' do
    subject(:place_board) { described_class.new }

    it 'updates that cell to contain the given value' do
      place_board.place_piece(Position.parse('d3'), 'n')
      expect(place_board.piece_at(Position.parse('d3'))).to eq 'n'
    end
  end

  describe '#piece_at' do
    context 'when the cell is empty' do
      subject(:empty_piece_at_board) { described_class.new }

      it 'returns a null piece' do
        expect(empty_piece_at_board.piece_at(Position.parse('d4'))).to be_a(NullPiece)
      end
    end

    context 'when the cell has a piece in it' do
      subject(:occupied_piece_at_board) { described_class.new }

      before do
        occupied_piece_at_board.place_piece(Position.parse('d4'), 'n')
      end

      it 'returns that piece' do
        expect(occupied_piece_at_board.piece_at(Position.parse('d4'))).to eq 'n'
      end
    end
  end
  
  describe '#initialize' do
    context 'when an empty board is made' do
      subject(:empty_board) { described_class.new }

      it 'the cells are assigned the right positions' do
        expect(empty_board.at(Position.parse('d4')).pos).to eq Position.parse('d4')
      end

      it 'a1 is a dark cell' do
        expect(empty_board.at(Position.parse('a1')).color).to eq :dark
      end

      it 'a2 is a light cell' do
        expect(empty_board.at(Position.parse('a2')).color).to eq :light
      end

      it 'b1 is a light cell' do
        expect(empty_board.at(Position.parse('b1')).color).to eq :light
      end

      it 'b2 is a dark cell' do
        expect(empty_board.at(Position.parse('b2')).color).to eq :dark
      end
    end
  end

  describe '#move' do
    subject(:move_board) { described_class.parse_fen('8/8/8/1r1R4/1r6/8/8/8 w - - 0 1') }

    context 'when destination and target are the same' do
      let(:move) { double('move') }


      before do
        allow(move).to receive_messages(from: Position.parse('d5'), to: Position.parse('b5'), target: Position.parse('b5'))
      end

      it 'changes the destination cell\'s piece' do
        move_board.move(move)
        expect(move_board.piece_at(Position.parse('b5'))).to eq Piece.parse('R', Position.parse('b5'))
      end

      it 'clears the cell that was moved from' do
        move_board.move(move)
        expect(move_board.piece_at(Position.parse('d4'))).to be_a(NullPiece)
      end
    end

    context 'when destination and target are different' do
      let(:move) { double('move') }

      before do
        allow(move).to receive_messages(from: Position.parse('d5'), to: Position.parse('b5'), target: Position.parse('b4'))
      end

      it 'changes the destination cell\'s piece' do
        move_board.move(move)
        expect(move_board.piece_at(Position.parse('b5'))).to eq Piece.parse('R', Position.parse('b5'))
      end

      it 'clears the cell that was moved from' do
        move_board.move(move)
        expect(move_board.piece_at(Position.parse('d4'))).to be_a(NullPiece)
      end

      it 'clears the target cell' do
        move_board.move(move)
        expect(move_board.piece_at(Position.parse('e4'))).to be_a(NullPiece)
      end
    end
  end

  describe '#self.parse_fen' do
    context 'when given the fen \'8/4r3/8/8/8/8/8/8\'' do
      subject(:board) { described_class.parse_fen('8/4r3/8/8/8/8/8/8') }

      it 'has a black rook at e7' do
        expect(board.piece_at(Position.parse('e7'))).to eq Piece.parse('r', Position.parse('e7'))
      end

      it 'all other squares are empty' do
        empty_squares = board.instance_variable_get(:@board).values.count(&:empty?)
        expect(empty_squares).to eq 63
      end
    end

    context 'when given the fen \'8/4r2R/3r4/8/8/8/r7/8\'' do
      subject(:board) { described_class.parse_fen('8/4r2R/3r4/8/8/8/R7/8') }

      it 'has a black rook at e7' do
        expect(board.piece_at(Position.parse('e7'))).to eq Piece.parse('r', Position.parse('e7'))
      end

      it 'has a black rook at d6' do
        expect(board.piece_at(Position.parse('d6'))).to eq Piece.parse('r', Position.parse('d6'))
      end

      it 'has a white rook at h7' do
        expect(board.piece_at(Position.parse('h7'))).to eq Piece.parse('R', Position.parse('h7'))
      end

      it 'has a white rook at a2' do
        expect(board.piece_at(Position.parse('a2'))).to eq Piece.parse('R', Position.parse('a2'))
      end

      it 'all other squares are empty' do
        empty_squares = board.instance_variable_get(:@board).values.count(&:empty?)
        expect(empty_squares).to eq 60
      end
    end
  end
end