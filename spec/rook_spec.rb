# frozen_string_literal: true

require_relative '../lib/library'

describe Rook do
  describe '#moves' do
    context 'with 8/8/8/3R4/8/8/8/8 (empty board, rook on d5)' do
      let(:board) { Board.parse_fen('8/8/8/3R4/8/8/8/8') }
      let(:moves) { board.piece_at(Position.parse('d5')).moves }

      it 'has 14 moves' do
        expect(moves.length).to eq 14
      end

      it 'can move to c5' do
        move = Move.new(Position.parse('d5'), Position.parse('c5'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to b5' do
        move = Move.new(Position.parse('d5'), Position.parse('b5'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to a5' do
        move = Move.new(Position.parse('d5'), Position.parse('a5'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to d6' do
        move = Move.new(Position.parse('d5'), Position.parse('d6'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to d7' do
        move = Move.new(Position.parse('d5'), Position.parse('d7'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to d8' do
        move = Move.new(Position.parse('d5'), Position.parse('d8'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to e5' do
        move = Move.new(Position.parse('d5'), Position.parse('e5'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to f5' do
        move = Move.new(Position.parse('d5'), Position.parse('f5'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to g5' do
        move = Move.new(Position.parse('d5'), Position.parse('g5'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to h5' do
        move = Move.new(Position.parse('d5'), Position.parse('h5'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to d4' do
        move = Move.new(Position.parse('d5'), Position.parse('d4'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to d3' do
        move = Move.new(Position.parse('d5'), Position.parse('d3'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to d2' do
        move = Move.new(Position.parse('d5'), Position.parse('d2'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to d1' do
        move = Move.new(Position.parse('d5'), Position.parse('d1'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end
    end

    context 'with 8/8/8/3R4/8/8/8/8 (empty board, rook on d5, enemy rook on e5)' do
      let(:board) { Board.parse_fen('8/8/8/3Rr3/8/8/8/8') }
      let(:moves) { board.piece_at(Position.parse('d5')).moves }

      it 'has 11 moves' do
        expect(moves.length).to eq 11
      end

      it 'can move to c5' do
        move = Move.new(Position.parse('d5'), Position.parse('c5'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to b5' do
        move = Move.new(Position.parse('d5'), Position.parse('b5'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to a5' do
        move = Move.new(Position.parse('d5'), Position.parse('a5'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to e5' do
        move = Move.new(Position.parse('d5'), Position.parse('e5'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to d6' do
        move = Move.new(Position.parse('d5'), Position.parse('d6'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to d7' do
        move = Move.new(Position.parse('d5'), Position.parse('d7'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to d8' do
        move = Move.new(Position.parse('d5'), Position.parse('d8'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to d4' do
        move = Move.new(Position.parse('d5'), Position.parse('d4'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to d3' do
        move = Move.new(Position.parse('d5'), Position.parse('d3'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to d2' do
        move = Move.new(Position.parse('d5'), Position.parse('d2'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end

      it 'can move to d1' do
        move = Move.new(Position.parse('d5'), Position.parse('d1'), [Rules::COLLISION, Rules::FRIENDLY_FIRE])
        expect(moves.include?(move)).to eq true
      end
    end
  end
end