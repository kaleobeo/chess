# frozen_string_literal: true

require_relative '../lib/library'

describe NullPosition do
  describe '#up' do
    it 'returns a NullPosition' do
      pos = described_class.new
      expect(pos.up).to eq described_class.new
    end
  end

  describe '#down' do
    it 'returns a NullPosition' do
      pos = described_class.new
      expect(pos.down).to eq described_class.new
    end
  end

  describe '#left' do
    it 'returns a NullPosition' do
      pos = described_class.new
      expect(pos.left).to eq described_class.new
    end
  end

  describe '#right' do
    it 'returns a NullPosition' do
      pos = described_class.new
      expect(pos.right).to eq described_class.new
    end
  end

  describe '#row' do
    it 'returns a NullPosition' do
      pos = described_class.new
      expect(pos.row).to be_nil
    end
  end

  describe '#col' do
    it 'returns a NullPosition' do
      pos = described_class.new
      expect(pos.col).to be_nil
    end
  end

  describe '#notation' do
    it 'returns a NullPosition' do
      pos = described_class.new
      expect(pos.notation).to be_nil
    end
  end

  describe '#horiz_line' do
    subject(:null_horiz_line) { described_class.new }

    it 'returns an array with the right number of NullPositions' do
      expected = [
        described_class.new,
        described_class.new,
        described_class.new,
        described_class.new,
        described_class.new
      ]

      expect(null_horiz_line.horiz_line(2)).to eq expected
    end
  end

  describe '#vert_line' do
    subject(:null_vert_line) { described_class.new }

    it 'returns an array with the right number of NullPositions' do
      expected = [
        described_class.new,
        described_class.new,
        described_class.new,
        described_class.new,
        described_class.new
      ]

      expect(null_vert_line.vert_line(2)).to eq expected
    end
  end

  describe '#diag_line_ne_sw' do
    subject(:null_diag_line) { described_class.new }

    it 'returns an array with the right number of NullPositions' do
      expected = [
        described_class.new,
        described_class.new,
        described_class.new,
        described_class.new,
        described_class.new
      ]

      expect(null_diag_line.diag_line_ne_sw(2)).to eq expected
    end
  end

  describe '#diag_line_nw_se' do
    subject(:null_diag_line) { described_class.new }

    it 'returns an array with the right number of NullPositions' do
      expected = [
        described_class.new,
        described_class.new,
        described_class.new,
        described_class.new,
        described_class.new
      ]

      expect(null_diag_line.diag_line_nw_se(2)).to eq expected
    end
  end
end
