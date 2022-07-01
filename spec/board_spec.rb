# frozen_string_literal: true

require_relative '../lib/library'

describe Board do
  describe '#place_piece' do
    subject(:place_board) { described_class.new }

    xit 'updates that cell to contain the given piece' do
      place_board.place_piece(Position.parse('d3'), 'n')
      expect(place_board.piece_at(Position.parse('d3'))).to eq 'n'
    end
  end
  
  describe '#initialize' do
    context 'when an empty board is made'
      subject(:empty_board) { described_class.new }
      xit 'the cells have the right positions' do
        expect(empty_board.at(Position.parse('d4')).pos).to eq Position.parse('d4')
      end
  end
end