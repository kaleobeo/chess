# frozen_string_literal: true

require_relative '../lib/library'

describe Square do
  describe '#piece_color' do
    context 'when there is no piece' do
      subject(:color_empty_square) { described_class.new(:dark, 'pos') }

      it 'returns nil' do
        expect(color_empty_square.piece_color).to be_nil
      end
    end

    context 'when there is a piece' do
      subject(:color_occupied_square) { described_class.new(:dark, 'pos') }

      let(:color_piece) { double('piece') }

      before do
        color_occupied_square.piece = color_piece
        allow(color_piece).to receive(:color).and_return(:black)
      end

      it 'returns that piece\'s color' do
        expect(color_occupied_square.piece_color).to eq :black
      end
    end
  end

  describe '#empty?' do
    context 'when the square is unoccupied' do
      subject(:empty_square) { described_class.new(:dark, 'pos') }

      it 'returns true' do
        expect(empty_square.empty?).to be true
      end
    end

    context 'when the square is occupied' do
      subject(:occupied_square) { described_class.new(:dark, 'pos') }

      let(:piece) { double('piece')}

      it 'returns false' do
        occupied_square.piece = piece
        expect(occupied_square.empty?).to be false
      end
    end
  end

  describe '#clear_piece' do
    subject(:clear_piece_square) { described_class.new(:dark, 'pos') }

    let(:piece) { double('piece') }

    it 'clears the piece' do
      clear_piece_square.piece = piece
      clear_piece_square.clear_piece
      expect(clear_piece_square).to be_empty
    end
  end
end