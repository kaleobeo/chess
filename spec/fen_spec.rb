# frozen_string_literal: true

require_relative '../lib/library'

describe Fen do
  describe '#place_en_passant' do
    context 'when given [..., ..., ..., e3 ...]' do
      subject(:en_passant_fen) { described_class.new('8/8/8/8/4P3/8/8/8 w - e3 0 1').place_pieces }

      it 'changes a pawn on e4 to be targetable by attack en passant' do
        en_passant_fen.place_en_passant
        expect(en_passant_fen.board.piece_at(Position.parse('e4')).can_en_passant?).to be true
      end
    end
  end
end