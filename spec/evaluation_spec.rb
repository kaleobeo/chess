# frozen_string_literal: true

require_relative '../lib/library'

describe Evaluation do
  describe '#in_check?' do
    context 'with 8/8/8/2k5/8/2K3r1/8/8 w - - 0 1' do
      subject(:check_evaluation) { described_class.new(Board.parse_fen('8/8/8/2k5/8/2K3r1/8/8 w - - 0 1')) }

      it 'white is in check' do
        expect(check_evaluation).to be_in_check(:white)
      end
    end

    context 'with 8/8/8/8/8/R1pk4/4P3/8 w - - 0 1' do
      subject(:check_evaluation) { described_class.new(Board.parse_fen('7K/8/8/8/8/R1pk4/4P3/8 w - - 0 1')) }

      it 'white is in check' do
        expect(check_evaluation).to be_in_check(:black)
      end
    end

    context 'with 8/8/8/8/8/R1pk4/8/8 w - - 0 1' do
      subject(:check_evaluation) { described_class.new(Board.parse_fen('8/8/8/8/8/R1pk4/8/8 w - - 0 1')) }

      it 'black is not in check' do
        expect(check_evaluation).not_to be_in_check(:black)
      end
    end

    context 'with 8/8/8/8/8/R1pk4/8/5B2 w - - 0 1' do
      subject(:check_evaluation) { described_class.new(Board.parse_fen('8/8/8/8/8/R1pk4/8/5B2 w - - 0 1')) }

      it 'black is in check' do
        expect(check_evaluation).to be_in_check(:black)
      end
    end
  end

  describe '#self.in_check_if?' do
    it 'does not change the board' do
      board = Board.parse_fen('7k/8/8/8/7r/2K5/8/8 w - - 0 1')
      expect { Evaluation.in_check_if?(board, Move.new(from: Position.parse('c3'), to: Position.parse('c4')), :white) }.not_to(change { board })
    end

    context 'with 7K/8/8/8/8/R1pk4/8/8 w - - 0 1' do
      let(:board) { Board.parse_fen('7K/8/8/8/8/R1pk4/8/8 w - - 0 1') }

      it 'is in check if black moves c4 ( discovered check )' do
        move = Move.new(from: Position.parse('c3'), to: Position.parse('c4'))
        expect(described_class.in_check_if?(board, move, :black)).to be true
      end
    end

    context 'with 7K/8/8/8/R7/2pk4/8/8 w - - 0 1' do
      let(:board) { Board.parse_fen('7K/8/8/8/R7/2pk4/8/8 w - - 0 1') }

      it 'is in check if black moves d4 ( move into check )' do
        move = Move.new(from: Position.parse('d3'), to: Position.parse('d4'))
        expect(described_class.in_check_if?(board, move, :black)).to be true
      end
    end
  end

  describe '#checkmate?' do
    context 'with 7k/6Q1/6K1/8/8/8/8/8 w - - 0 1' do
      subject(:checkmate_evaluation) { described_class.new(board) }

      let(:board) { Board.parse_fen('7k/6Q1/6K1/8/8/8/8/8 w - - 0 1') }

      it 'black is in checkmate' do
        expect(checkmate_evaluation).to be_in_checkmate(:black)
      end
    end

    context 'with k7/8/NKB5/8/8/8/8/8 w - - 0 1' do
      subject(:checkmate_evaluation) { described_class.new(board) }

      let(:board) { Board.parse_fen('k7/8/NKB5/8/8/8/8/8 w - - 0 1') }

      it 'black is in checkmate' do
        expect(checkmate_evaluation).to be_in_checkmate(:black)
      end
    end
  end

  describe '#stalemate?' do
    context 'with 7k/6R1/5K2/8/8/8/8/8 w - - 0 1' do
      subject(:stalemate_validator) { described_class.new(board) }

      let(:board) { Board.parse_fen('7k/6R1/5K2/8/8/8/8/8 w - - 0 1') }

      it 'black is in stalemate' do
        expect(stalemate_validator).to be_in_stalemate(:black)
      end
    end

    context 'with R6k/6R1/5K2/8/8/8/8/8 w - - 0 1 ( checkmate )' do
      subject(:stalemate_validator) { described_class.new(board) }

      let(:board) { Board.parse_fen('R6k/6R1/5K2/8/8/8/8/8 w - - 0 1') }

      it 'black is not in stalemate' do
        expect(stalemate_validator).not_to be_in_stalemate(:black)
      end
    end

    context 'with Rp5k/6R1/5K2/8/8/8/8/8 w - - 0 1 ( discovered checkmate)' do
      subject(:stalemate_validator) { described_class.new(board) }

      let(:board) { Board.parse_fen('Rp5k/6R1/5K2/8/8/8/8/8 w - - 0 1') }

      it 'black is in stalemate' do
        expect(stalemate_validator).to be_in_stalemate(:black)
      end
    end
  end
  
  describe '#find_promotable_pawn' do
    context 'with P5k1/4rp1p/1P4p1/8/8/8/1PP5/2K5 w - - 0 1' do
      subject(:promotion_evaluation) { described_class.new(board) }

      let(:board) { Board.parse_fen('P5k1/4rp1p/1P4p1/8/8/8/1PP5/2K5 w - - 0 1') }

      it 'returns a8 pawn' do
        expect(promotion_evaluation.find_promotable_pawn(:white)).to be board.piece_at(Position.parse('a8'))
      end
    end

    context 'with 6k1/P3rp1p/1P4p1/8/8/8/1PP5/2K1p3 w - - 0 1' do
      subject(:promotion_evaluation) { described_class.new(board) }

      let(:board) { Board.parse_fen('6k1/P3rp1p/1P4p1/8/8/8/1PP5/2K1p3 w - - 0 1') }

      it 'returns e1 pawn' do
        expect(promotion_evaluation.find_promotable_pawn(:black)).to be board.piece_at(Position.parse('e1'))
      end
    end

    context 'with 6k1/P3rp1p/1P4p1/8/8/8/2P5/2K5 w - - 0 1' do
      subject(:promotion_evaluation) { described_class.new(board) }

      let(:board) { Board.parse_fen('6k1/P3rp1p/1P4p1/8/8/8/2P5/2K5 w - - 0 1') }

      it 'returns nil when called with :white' do
        expect(promotion_evaluation.find_promotable_pawn(:white)).to be_nil
      end

      it 'returns nil when called with :black' do
        expect(promotion_evaluation.find_promotable_pawn(:black)).to be_nil
      end
    end
  end

  describe '#fifty_move_clock_exceeded?' do
    context 'when half move clock of board is over 100' do
      subject(:fifty_move_evaluation) { described_class.new(board) }

      let(:board) { Board.parse_fen('rnbqkb1r/ppppp1pp/7n/4Pp2/8/8/PPPP1PPP/RNBQKBNR b KQkq f6 102 3') }

      it 'returns true' do
        expect(fifty_move_evaluation.fifty_move_clock_exceeded?).to be true
      end
    end

    context 'when half move clock of board is less than 100' do
      subject(:fifty_move_evaluation) { described_class.new(board) }

      let(:board) { Board.parse_fen('rnbqkb1r/ppppp1pp/7n/4Pp2/8/8/PPPP1PPP/RNBQKBNR b KQkq f6 56 3') }

      it 'returns false' do
        expect(fifty_move_evaluation.fifty_move_clock_exceeded?).to be false
      end
    end
  end

  describe '#insufficient_material?' do
    context 'with 5n1k/8/8/8/8/8/8/K1N5 w - - 0 1 (KN vs kn)' do
      subject(:insufficient_material_eval) { described_class.new(board) }

      let(:board) { Board.parse_fen('5n1k/8/8/8/8/8/8/K1N5 w - - 0 1') }

      it 'returns true' do
        expect(insufficient_material_eval.insufficient_material?).to be true
      end
    end

    context 'with 7k/8/8/8/8/8/8/K1N5 w - - 0 1 (KN vs k)' do
      subject(:insufficient_material_eval) { described_class.new(board) }

      let(:board) { Board.parse_fen('7k/8/8/8/8/8/8/K1N5 w - - 0 1') }

      it 'returns true' do
        expect(insufficient_material_eval.insufficient_material?).to be true
      end
    end

    context 'with 5b1k/8/8/8/8/8/8/K1B5 w - - 0 1 (KB vs kb, same color bishops)' do
      subject(:insufficient_material_eval) { described_class.new(board) }

      let(:board) { Board.parse_fen('5b1k/8/8/8/8/8/8/K1B5 w - - 0 1') }

      it 'returns true' do
        expect(insufficient_material_eval.insufficient_material?).to be true
      end
    end

    context 'with 6bk/8/8/8/8/8/8/K1B5 w - - 0 1 (KB vs kb, different color bishops)' do
      subject(:insufficient_material_eval) { described_class.new(board) }

      let(:board) { Board.parse_fen('6bk/8/8/8/8/8/8/K1B5 w - - 0 1') }

      it 'returns false' do
        expect(insufficient_material_eval.insufficient_material?).to be false
      end
    end

    context 'with 7k/8/8/8/8/8/8/K1B5 w - - 0 1 (KB vs k)' do
      subject(:insufficient_material_eval) { described_class.new(board) }

      let(:board) { Board.parse_fen('7k/8/8/8/8/8/8/K1B5 w - - 0 1') }

      it 'returns true' do
        expect(insufficient_material_eval.insufficient_material?).to be true
      end
    end

    context 'with 7k/8/8/8/8/8/8/K7 w - - 0 1 (k vs K)' do
      subject(:insufficient_material_eval) { described_class.new(board) }

      let(:board) { Board.parse_fen('7k/8/8/8/8/8/8/K7 w - - 0 1') }

      it 'returns true' do
        expect(insufficient_material_eval.insufficient_material?).to be true
      end
    end
  end
end