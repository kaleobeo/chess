# frozen_string_literal: true

require_relative '../lib/library'

describe NullPiece do
  describe '#self.represented_by?' do
    it 'returns true to an invalid letter' do
      outcome = described_class.represented_by?('X')
      expect(outcome).to be true
    end

    it 'returns true to an invalid symbol' do
      outcome = described_class.represented_by?('-')
      expect(outcome).to be true
    end
  end

  describe 'moves' do
    subject(:move_piece) { described_class.new }

    it 'returns an empty array' do
      expect(move_piece.moves).to eq []
    end
  end

  describe '#friendly_to?' do
    subject(:friendly_null_piece) { described_class.new }

    it 'returns false to a white piece' do
      attacker = Piece.parse('R', Position.parse('a1'), Board.new)
      expect(friendly_null_piece.friendly_to?(attacker)).to be false
    end

    it 'returns false to a black piece' do
      attacker = Piece.parse('r', Position.parse('a1'), Board.new)
      expect(friendly_null_piece.friendly_to?(attacker)).to be false
    end
  end
end
