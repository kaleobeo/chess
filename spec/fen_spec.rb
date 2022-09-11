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
      subject(:en_passant_fen) do
        described_class.new(fen_string: 'rnbqkbnr/ppp1pppp/8/3p4/3P4/8/PPP1PPPP/RNBQKBNR w KQkq d6 0 2').place_pieces
      end

      it 'pawn on d6 is targetable by attack en passant' do
        en_passant_fen.place_en_passant
        expect(en_passant_fen.board.piece_at(Position.parse('d5')).can_en_passant?).to be true
      end
    end
  end

  describe '#revoke castling rights' do
    context 'with r3k2r/pppppppp/8/8/8/8/PPPPPPPP/R3K2R w KQkq - 0 1' do
      subject(:castle_fen) do
        described_class.new(fen_string: 'r3k2r/pppppppp/8/8/8/8/PPPPPPPP/R3K2R w KQkq - 0 1').place_pieces
      end

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
      subject(:castle_fen) do
        described_class.new(fen_string: 'r3k2r/pppppppp/8/8/8/8/PPPPPPPP/R3K2R w Kk - 0 1').place_pieces
      end

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
      subject(:castle_fen) do
        described_class.new(fen_string: 'r3k2r/pppppppp/8/8/8/8/PPPPPPPP/R3K2R w Qq - 0 1').place_pieces
      end

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
      subject(:castle_fen) do
        described_class.new(fen_string: 'r3k2r/pppppppp/8/8/8/8/PPPPPPPP/R3K2R w - - 0 1').place_pieces
      end

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

  describe '#set_en_passant_field' do
    context 'after 1. d4' do
      let(:board) { Board.parse_fen }
      let(:set_en_passant_field_fen) { described_class.new(board:) }
      let(:pawn) { board.piece_at(Position.parse('d2')) }

      before do
        double_move = pawn.moves.find { |move| move.rules.include?(Rules::ON_START_POSITION) }
        board.move(double_move)
      end

      it 'sets en passant field to d3' do
        set_en_passant_field_fen.set_en_passant_field
        expect(set_en_passant_field_fen.fen_arr[3]).to eq 'd3'
      end
    end

    context 'when on start positions' do
      let(:board) { Board.parse_fen }
      let(:set_en_passant_field_fen) { described_class.new(board:) }
      let(:pawn) { board.piece_at(Position.parse('d2')) }

      it 'sets en passant field to -' do
        set_en_passant_field_fen.set_en_passant_field
        expect(set_en_passant_field_fen.fen_arr[3]).to eq '-'
      end
    end
  end

  describe '#set_castle_field' do
    context 'when on start positions' do
      subject(:start_positions_castle_field_fen) { described_class.new(board: Board.parse_fen) }

      it 'castle field is "KQkq"' do
        start_positions_castle_field_fen.set_castle_field
        expect(start_positions_castle_field_fen.fen_arr[2]).to eq 'KQkq'
      end
    end

    context 'when white kingside rook has moved' do
      subject(:kingside_rook_moved_castle_fen) { described_class.new(board:) }

      let(:board) { Board.parse_fen }

      before do
        board.piece_at(Position.parse('h1')).moved(Move.new(from: Position.parse('h1'), to: Position.parse('h1')))
        kingside_rook_moved_castle_fen.set_castle_field
      end

      it 'castle field is "Qkq"' do
        expect(kingside_rook_moved_castle_fen.fen_arr[2]).to eq 'Qkq'
      end
    end

    context 'when white queenside rook has moved' do
      subject(:queenside_rook_moved_castle_fen) { described_class.new(board:) }

      let(:board) { Board.parse_fen }

      before do
        board.piece_at(Position.parse('a1')).moved(Move.new(from: Position.parse('a1'), to: Position.parse('a1')))
        queenside_rook_moved_castle_fen.set_castle_field
      end

      it 'castle field is "Kkq"' do
        expect(queenside_rook_moved_castle_fen.fen_arr[2]).to eq 'Kkq'
      end
    end

    context 'when white king has moved' do
      subject(:white_king_moved_castle_fen) { described_class.new(board:) }

      let(:board) { Board.parse_fen }

      before do
        board.piece_at(Position.parse('e1')).moved(Move.new(from: Position.parse('e1'), to: Position.parse('e1')))
        white_king_moved_castle_fen.set_castle_field
      end

      it 'castle field is kq' do
        expect(white_king_moved_castle_fen.fen_arr[2]).to eq 'kq'
      end
    end
  end
end
