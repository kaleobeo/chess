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
  end

  describe '#self.in_check_if?' do
    it 'does not change the board' do
      board = Board.parse_fen('7k/8/8/8/7r/2K5/8/8 w - - 0 1')
      expect { Evaluation.in_check_if?(board, Move.new(from: Position.parse('c3'), to: Position.parse('c4')), :white) }.not_to(change { board })
      
    end
  end
end