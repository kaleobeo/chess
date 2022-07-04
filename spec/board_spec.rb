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

      it 'returns nil' do
        expect(empty_piece_at_board.piece_at(Position.parse('d4'))).to be_nil
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
end