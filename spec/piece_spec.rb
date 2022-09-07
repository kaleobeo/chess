# frozen_string_literal: true

require_relative '../lib/library'

describe Piece do
  describe '#==' do
    subject(:equality_piece) { described_class.new('R', Position.parse('a1'), :board) }
    context 'when class, color, pos, and board are the same' do
      let(:equal_piece) { described_class.new('R', Position.parse('a1'), :board) }

      it 'returns true' do
        expect(equality_piece).to eq equal_piece
      end
    end

    context 'when an attribute is different' do
      let(:unequal_piece) { described_class.new('r', Position.parse('a2'), :board) }

      it 'returns false' do
        expect(equality_piece).not_to eq unequal_piece
      end
    end
  end

  describe '#friendly_to?' do
    subject(:black_piece) { described_class.new('R', Position.parse('a1'), :board) }

    context 'when pieces are the same color' do
      let(:ally_piece) { described_class.new('R', Position.parse('h4'), :board) }

      it 'returns true' do
        expect(black_piece).to be_friendly_to(ally_piece)
      end
    end

    context 'when pieces are not the same color' do
      let(:enemy_piece) { described_class.new('r', Position.parse('h4'), :board) }

      it 'returns false' do
        expect(black_piece).not_to be_friendly_to(enemy_piece)
      end
    end
  end

  describe '#self.represented_by?' do
    it 'raises a NotImplementedError' do
      expect { described_class.represented_by?('P') }.to raise_error(NotImplementedError)
    end
  end

  describe '#square_color' do
    subject(:piece) { described_class.new('R', Position.parse('a1'), Board.new) }

    it 'returns the color of the square the piece is on' do
      expect(piece.square_color).to be :dark
    end
  end
end