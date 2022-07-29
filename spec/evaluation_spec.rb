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
end