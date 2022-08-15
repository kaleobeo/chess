# frozen_string_literal: true

require_relative '../lib/library'

describe Fen do
  describe '#place_en_passant' do
    context 'when given [..., ..., ..., e3 ...]' do
      subject(:en_passant_fen) { described_class.new(fen_string: '8/8/8/8/4P3/8/8/8 w - e3 0 1').place_pieces }

      it 'pawn on e4 is targetable by attack en passant' do
        en_passant_fen.place_en_passant
        expect(en_passant_fen.board.piece_at(Position.parse('e4')).can_en_passant?).to be true
      end
    end

    context 'when given [..., ..., ..., d6 ...]' do
      subject(:en_passant_fen) { described_class.new(fen_string: 'rnbqkbnr/ppp1pppp/8/3p4/3P4/8/PPP1PPPP/RNBQKBNR w KQkq d6 0 2').place_pieces }

      it 'pawn on d6 is targetable by attack en passant' do
        en_passant_fen.place_en_passant
        expect(en_passant_fen.board.piece_at(Position.parse('d5')).can_en_passant?).to be true
      end
    end
  end

  describe '#revoke castling rights' do
    context 'with r3k2r/pppppppp/8/8/8/8/PPPPPPPP/R3K2R w KQkq - 0 1' do
      subject(:castle_fen) { described_class.new(fen_string: 'r3k2r/pppppppp/8/8/8/8/PPPPPPPP/R3K2R w KQkq - 0 1').place_pieces }

      before do
        castle_fen.revoke_castling_rights
      end

      it 'white king can castle kingside' do
        white_king_moves = castle_fen.board.destinations_for(Position.parse('e1'))
        expect(white_king_moves).to include Position.parse('g1')
      end

      it 'white king can castle queenside' do
        white_king_moves = castle_fen.board.destinations_for(Position.parse('e1'))
        expect(white_king_moves).to include Position.parse('c1')
      end

      it 'black king can castle kingside' do
        black_king_moves = castle_fen.board.destinations_for(Position.parse('e8'))
        expect(black_king_moves).to include Position.parse('g8')
      end

      it 'black king can castle queenside' do
        black_king_moves = castle_fen.board.destinations_for(Position.parse('e8'))
        expect(black_king_moves).to include Position.parse('c8')
      end
    end

    context 'with r3k2r/pppppppp/8/8/8/8/PPPPPPPP/R3K2R w Kk - 0 1' do
      subject(:castle_fen) { described_class.new(fen_string: 'r3k2r/pppppppp/8/8/8/8/PPPPPPPP/R3K2R w Kk - 0 1').place_pieces }

      before do
        castle_fen.revoke_castling_rights
      end

      it 'white king can castle kingside' do
        white_king_moves = castle_fen.board.destinations_for(Position.parse('e1'))
        expect(white_king_moves).to include Position.parse('g1')
      end

      it 'white king cannot castle queenside' do
        white_king_moves = castle_fen.board.destinations_for(Position.parse('e1'))
        expect(white_king_moves).not_to include Position.parse('c1')
      end

      it 'black king can castle kingside' do
        black_king_moves = castle_fen.board.destinations_for(Position.parse('e8'))
        expect(black_king_moves).to include Position.parse('g8')
      end

      it 'black king cannot castle queenside' do
        black_king_moves = castle_fen.board.destinations_for(Position.parse('e8'))
        expect(black_king_moves).not_to include Position.parse('c8')
      end
    end

    context 'with r3k2r/pppppppp/8/8/8/8/PPPPPPPP/R3K2R w Qq - 0 1' do
      subject(:castle_fen) { described_class.new(fen_string: 'r3k2r/pppppppp/8/8/8/8/PPPPPPPP/R3K2R w Qq - 0 1').place_pieces }

      before do
        castle_fen.revoke_castling_rights
      end

      it 'white king cannot castle kingside' do
        white_king_moves = castle_fen.board.destinations_for(Position.parse('e1'))
        expect(white_king_moves).not_to include Position.parse('g1')
      end

      it 'white king can castle queenside' do
        white_king_moves = castle_fen.board.destinations_for(Position.parse('e1'))
        expect(white_king_moves).to include Position.parse('c1')
      end

      it 'black king cannot castle kingside' do
        black_king_moves = castle_fen.board.destinations_for(Position.parse('e8'))
        expect(black_king_moves).not_to include Position.parse('g8')
      end

      it 'black king can castle queenside' do
        black_king_moves = castle_fen.board.destinations_for(Position.parse('e8'))
        expect(black_king_moves).to include Position.parse('c8')
      end
    end

    context 'with r3k2r/pppppppp/8/8/8/8/PPPPPPPP/R3K2R w - - 0 1' do
      subject(:castle_fen) { described_class.new(fen_string: 'r3k2r/pppppppp/8/8/8/8/PPPPPPPP/R3K2R w - - 0 1').place_pieces }

      before do
        castle_fen.revoke_castling_rights
      end

      it 'white king cannot castle kingside' do
        white_king_moves = castle_fen.board.destinations_for(Position.parse('e1'))
        expect(white_king_moves).not_to include Position.parse('g1')
      end

      it 'white king cannot castle queenside' do
        white_king_moves = castle_fen.board.destinations_for(Position.parse('e1'))
        expect(white_king_moves).not_to include Position.parse('c1')
      end

      it 'black king cannot castle kingside' do
        black_king_moves = castle_fen.board.destinations_for(Position.parse('e8'))
        expect(black_king_moves).not_to include Position.parse('g8')
      end

      it 'black king cannot castle queenside' do
        black_king_moves = castle_fen.board.destinations_for(Position.parse('e8'))
        expect(black_king_moves).not_to include Position.parse('c8')
      end
    end
  end
end